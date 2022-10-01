extends Ally

onready var _laser_beam = $Sprite/LaserBeam
onready var _shuttlepod_constructor = preload("res://SpaceElements/Characters/Allies/Enterprise/ShuttlePod/ShuttlePod.tscn")

func _ready():
	_fire = $Sprite/Fire
	first_group = "enterprise"
	_initial_speed = speed
	$Sprite/LaserBeam.damage_caused = damage_caused

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally()

func _on_LaserBeamTimer_timeout():
	_laser_beam.set_is_casting(true)

func add_damage(value: int):
	damage_added += value
	_laser_beam.damage_caused += value
	
func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		for child in $Sprite/ShuttlePod.get_children():
			var shuttlepod = _shuttlepod_constructor.instance()
			shuttlepod.set_as_toplevel(true)
			shuttlepod.global_position = child.global_position
			shuttlepod._position = child
			shuttlepod.speed = speed
			add_child(shuttlepod)

func _on_CollisionZone_body_exited(body):
	if (body is Ally 
		and body.get_parent() != self 
		and not is_player 
	):
		end_collision()

func _on_CollisionZone_body_entered(body):
	if (body is Ally 
		and body.get_parent() != self 
		and not is_player 
	):
		collision_detected(body)

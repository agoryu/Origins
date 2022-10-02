extends Ally

onready var _laser_beam = $Sprite/LaserBeam
onready var _shuttlepod_constructor = preload("res://SpaceElements/Characters/Allies/Enterprise/ShuttlePod/ShuttlePod.tscn")

func _ready():
	on_ready()
	first_group = "enterprise"
	$Sprite/LaserBeam.damage_caused = damage_caused

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally()

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

func _on_ShootTimer_timeout():
	_laser_beam.set_is_casting(true)

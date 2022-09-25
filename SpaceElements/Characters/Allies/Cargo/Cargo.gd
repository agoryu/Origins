extends Ally

func _ready():
	_fire = $Sprite/Fire
	first_group = "cargo"
	_initial_speed = speed
	fire_scale = 3.0

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move_ally()

func add_damage(value: int):
	damage_added += value
	
func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		pass

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

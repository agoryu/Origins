extends Hunter

onready var laser_shoot_constructor = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")

var _is_first_fire: bool = true

func _ready():
	_fire = $Sprite/Fire
	_weapon = $Weapons
	_initial_speed = speed
	_state = STATE.FOLLOW_PLAYER
	first_group = "xwing"

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move()

func _on_FireTimer_timeout():
	var positions_fire = _weapon.get_node("FirstShoot") if _is_first_fire else _weapon.get_node("SecondShoot")
	_is_first_fire = !_is_first_fire
	for position_fire in positions_fire.get_children():
			var laser_shoot = laser_shoot_constructor.instance()
			laser_shoot.global_position = position_fire.global_position
			laser_shoot.rotation = _sprite.rotation
			add_child(laser_shoot)
			laser_shoot.set_as_toplevel(true)
			laser_shoot.damage_caused += damage_added
			laser_shoot.scale /= 2.0
	shoot_counter += 1

func _on_TargetTimer_timeout():
	_state = STATE.WAIT_TARGET
	
func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		pass

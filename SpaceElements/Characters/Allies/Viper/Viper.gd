extends Hunter

class_name Viper

onready var _gun_constructor = preload("res://SpaceElements/Weapons/Gun/Gun.tscn")

func _ready():
	_weapon = $Weapons
	_fire = $Sprite/Fire
	_state = STATE.FOLLOW_PLAYER
	_initial_speed = speed
	first_group = "viper"

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move()

func _on_TargetTimer_timeout():
	_state = STATE.WAIT_TARGET

func _on_ShootTimer_timeout():
	shoot_counter += 1
	for gun in _weapon.get_children():
		var gun_shoot = _gun_constructor.instance()
		gun_shoot.rotation = _sprite.rotation
		gun_shoot.global_position = gun.global_position
		add_child(gun_shoot)
		gun_shoot.set_as_toplevel(true)
		gun_shoot.damage_caused = damage_caused + damage_added
		
func set_cooldown(value: float):
	.set_cooldown(value)
	_target_timer.wait_time = value * 10.0
	
func set_speed(value: int):
	.set_speed(value)
	_initial_speed += value

func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		shoot_timer.one_shot = false

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
		and not body.is_player
	):
		collision_detected(body)

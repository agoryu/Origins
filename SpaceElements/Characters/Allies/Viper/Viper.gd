extends Hunter

class_name Viper

onready var _gun_constructor = preload("res://SpaceElements/Weapons/Gun/Gun.tscn")

func _ready():
	on_ready()
	_weapon = $Weapons
	_state = STATE.FOLLOW_PLAYER
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

func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		_shoot_timer.one_shot = false

extends Hunter

onready var laser_shoot_constructor = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")
onready var photon_shoot_constructor = preload("res://SpaceElements/Weapons/Photon/Photon.tscn")

func _ready():
	on_ready()
	_weapon = $Weapons
	_state = STATE.WAIT_TARGET
	first_group = "xwing"

func _physics_process(delta):
	if is_player:
		player_move()
	else:
		move()

func _on_TargetTimer_timeout():
	_state = STATE.WAIT_TARGET
	
func lvl_up():
	.lvl_up()
	if lvl >= MAX_LVL:
		$PhotonTimer.start()

func _on_ShootTimer_timeout():
	var positions_fire = _weapon.get_node("FirstShoot") if shoot_counter % 2 else _weapon.get_node("SecondShoot")
	for position_fire in positions_fire.get_children():
			var laser_shoot = laser_shoot_constructor.instance()
			laser_shoot.global_position = position_fire.global_position
			laser_shoot.rotation = _sprite.rotation
			add_child(laser_shoot)
			laser_shoot.set_as_toplevel(true)
			laser_shoot.damage_caused = damage_caused + damage_added
			laser_shoot.scale /= 2.0
	shoot_counter += 1
	
func set_cooldown(value: float):
	.set_cooldown(value)
	_target_timer.wait_time = value * 10.0

func _on_PhotonTimer_timeout():
	var photon_shoot = photon_shoot_constructor.instance()
	photon_shoot.global_position = $Weapons/PhotonPosition.global_position
	photon_shoot.rotation = _sprite.rotation
	add_child(photon_shoot)
	photon_shoot.set_as_toplevel(true)

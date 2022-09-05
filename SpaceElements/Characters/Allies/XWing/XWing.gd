extends Hunter

export var distance_fire: int = 100

onready var laser_shoot_constructore = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")
onready var collision_shape = $CollisionShape2D
onready var follow_timer = $FollowTimer
onready var fire_timer = $FireTimer
onready var _fires = $Sprite/Fires

var _is_first_fire: bool = true

func _ready():
	_weapon = $Weapons
	_on_FireTimer_timeout()

func _physics_process(delta):
	if is_player:
		player_move(delta)
	else:
		move(delta)
		
	if wait_time_collision == 0:
		var speed_rate : float = _velocity.length() / speed
		var fire_scale = Vector2.ONE * speed_rate * 0.5
		for fire in _fires.get_children():
			fire.scale = fire_scale

func move(delta: float):
	if not is_valid_target():
		move_ally(delta, FleetManager.player)
		if global_position.distance_to(FleetManager.player.global_position) < limit_distance and collision_shape.disabled:
			collision_shape.disabled = false
		if follow_timer.is_stopped():
			follow_timer.start(5)
	else:
		if global_position.distance_to(_target.global_position) > distance_fire:
			direction = global_position.direction_to(_target.global_position)
			move_in_direction(direction)
		elif fire_timer.is_stopped() and fire_timer.is_stopped():
			_on_FireTimer_timeout()
			_sprite.global_rotation = (_target.global_position - global_position).angle() + PI/2.0 
		
func _on_FollowTimer_timeout():
	if is_player:
		_on_FireTimer_timeout()
		return
		
	var collision_bodies = detection_zone.get_overlapping_bodies()
	var distance_tmp = -1
	for body in collision_bodies:
		var distance_collision_body = global_position.distance_to(body.global_position)
		if not is_valid_target() or distance_tmp > distance_collision_body:
			_target = body
			distance_tmp = distance_collision_body
	
	if is_valid_target():
		collision_shape.disabled = true
	else:
		follow_timer.start(1)

func _on_FireTimer_timeout():
	fire()
	if _is_first_fire and is_valid_target():
		_is_first_fire = false
		fire_timer.start()
	else:
		_is_first_fire = true
		_target = null
		follow_timer.start()
		
func fire():
	var positions_fire = _weapon.get_node("FirstShoot") if _is_first_fire else _weapon.get_node("SecondShoot")
	for position_fire in positions_fire.get_children():
			var laser_shoot = laser_shoot_constructore.instance()
			laser_shoot.global_position = position_fire.global_position
			laser_shoot.rotation = _sprite.rotation
			add_child(laser_shoot)
			laser_shoot.set_as_toplevel(true)
			laser_shoot.damage_caused += damage_added
			laser_shoot.scale /= 2.0
			
func set_is_player(value: bool):
	.set_is_player(value)
	if value:
		follow_timer.one_shot = false
	else:
		follow_timer.one_shot = true

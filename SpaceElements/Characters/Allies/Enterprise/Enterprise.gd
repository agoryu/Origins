extends Ally

onready var _laser_beam_timer = $LaserBeamTimer
onready var _laser_beam = $Sprite/LaserBeam

onready var _fire1 = $Sprite/Fire1
onready var _fire2 = $Sprite/Fire2

func _physics_process(delta):
	if is_player:
		player_move(delta)
	else:
		move_ally(delta, FleetManager.player)
		
	if wait_time_collision == 0:
		var speed_rate : float = _velocity.length() / speed
		_fire1.scale = Vector2.ONE * speed_rate * 0.2
		_fire2.scale = Vector2.ONE * speed_rate * 0.2

func _on_LaserBeamTimer_timeout():
	_laser_beam.set_is_casting(true)

func add_damage(value: int):
	damage_added += value
	_laser_beam.damage_caused += value

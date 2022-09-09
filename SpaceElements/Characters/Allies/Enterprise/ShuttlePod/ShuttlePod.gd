extends Hunter

class_name ShuttlePod

onready var _laser_beam = $Sprite/LaserBeam

var _position : Position2D

func _ready():
	_fire = $Sprite/Fire
	_state = STATE.FOLLOW_PLAYER
	_initial_speed = speed
	first_group = "shuttlepod"
	limit_distance = 50

func _physics_process(delta):
	move()

func _on_TargetTimer_timeout():
	_state = STATE.WAIT_TARGET

func _on_ShootTimer_timeout():
	_laser_beam.set_is_casting(true)
	shoot_counter += 1
	
func move_ally():
	if global_position.distance_to(_position.global_position) > limit_distance:
		move_in_direction(global_position.direction_to(_position.global_position))

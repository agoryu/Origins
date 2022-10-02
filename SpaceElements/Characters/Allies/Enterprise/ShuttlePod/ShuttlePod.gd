extends Hunter

class_name ShuttlePod

onready var _laser_beam = $Sprite/LaserBeam

var _position : Position2D
var min_distance = 50

func _ready():
	_fire = $Sprite/Fire
	_state = STATE.FOLLOW_PLAYER
	_initial_speed = speed
	first_group = "shuttlepod"

func _physics_process(delta):
	move()

func _on_TargetTimer_timeout():
	_state = STATE.WAIT_TARGET

func _on_ShootTimer_timeout():
	_laser_beam.set_is_casting(true)
	yield(_laser_beam, "end_shoot")
	shoot_counter += 1
	
func move_ally():
	var distance = global_position.distance_to(_position.global_position)
	
	if distance > min_distance:
		move_in_direction(global_position.direction_to(_position.global_position))
	elif _state == STATE.GO_BACK:
		_state = STATE.FOLLOW_PLAYER
	
func go_back():
	speed = _initial_speed
	move_ally()

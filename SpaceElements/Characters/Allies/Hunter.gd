extends Ally

class_name Hunter

export var distance_fire = 300
export var nb_shoot = 4

enum STATE {
	FOLLOW_PLAYER,
	FOLLOW_TARGET,
	FIRE_TARGET,
	WAIT_TARGET,
	GO_BACK
}

onready var detection_zone = $DetectionZone
onready var _target_timer = $TargetTimer

const DISTANCE_MAX_SPEED = 200

var _target = null
var _state = null
var shoot_counter = 0

func is_valid_target() -> bool:
	return _target != null and is_instance_valid(_target)
	
func is_valid_priority(body: SpaceElement) -> bool:
	return (_target as SpaceElement).priority_target <= body.priority_target
	
func find_target():
	var collision_bodies = detection_zone.get_overlapping_bodies()
	var distance_tmp = 5000
	for body in collision_bodies:
		var distance_collision_body = global_position.distance_to(body.global_position)
		if (
			not is_valid_target() or 
			is_valid_priority(body)
		) and (
			distance_tmp > distance_collision_body and
			is_target_not_use(body)
		):
			_target = body
			distance_tmp = distance_collision_body
			
func move_on_target() -> int:
	if is_valid_target():
		var distance_target = global_position.distance_to(_target.global_position)
		if (_target as SpaceElement)._collision.shape is CircleShape2D:
			distance_target -= (_target as SpaceElement)._collision.shape.radius
		speed = distance_target * _initial_speed / DISTANCE_MAX_SPEED
		speed = speed if speed < _initial_speed else _initial_speed
		move_in_direction(global_position.direction_to(_target.global_position))
		return distance_target
	return -1
	
func is_target_not_use(target: SpaceElement):
	if not is_valid_target():
		return true
	for ship in get_tree().get_nodes_in_group("hunter"):
		if target == ship._target:
			return false
	return true
	
func move():
	match _state:
		STATE.FOLLOW_PLAYER:
			move_ally()
			if _target_timer.is_stopped():
				_target_timer.start()
		STATE.FOLLOW_TARGET:
			speed = _initial_speed
			if is_valid_target():
				var target_distance = move_on_target()
				_collision.disabled = true
				if target_distance <= distance_fire and target_distance != -1:
					_state = STATE.FIRE_TARGET
			else:
				_state = STATE.WAIT_TARGET
		STATE.FIRE_TARGET:
			var target_distance = move_on_target()
			if target_distance == -1 and shoot_counter < nb_shoot:
				_state = STATE.WAIT_TARGET
			else:
				if shoot_counter >= nb_shoot:
					shoot_counter = 0
					_state = STATE.GO_BACK
				elif _shoot_timer.is_stopped():
					_shoot_timer.start()
		STATE.WAIT_TARGET:
			find_target()
			if is_valid_target():
				_state = STATE.FOLLOW_TARGET
			else:
				move_ally()
		STATE.GO_BACK:
			go_back()
			
func go_back():
	var distance_player = global_position.distance_to(FleetManager.player.global_position)
	if distance_player <= limit_distance:
		_state = STATE.FOLLOW_PLAYER
		_collision.disabled = false
	move_ally()

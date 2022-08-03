extends KinematicBody2D

class_name SpaceElement

export var speed = 1000.0
export var drag := 4.0
export var damage_caused : int = 1

var _velocity = Vector2.ZERO

func impact_damage(value_of_damage: int):
	pass
	
func move_in_direction(direction: Vector2):
	var desired_velocity = direction * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / drag
	_velocity = _velocity.clamped(speed)
	_velocity = move_and_slide(_velocity)

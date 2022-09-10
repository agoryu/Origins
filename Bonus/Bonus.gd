extends Area2D

class_name Bonus

export var value : int = 1

const DRAG := 14.0
var max_speed := 400.0

var _velocity := Vector2.ZERO

func attract(delta: float):
	var attractors := get_overlapping_areas()

	if attractors:
		var desired_velocity: Vector2 = (
			(attractors[0].global_position - global_position).normalized() * max_speed
		)
		var steering := desired_velocity - _velocity
		_velocity += steering / DRAG
	else:
		_velocity = Vector2.ZERO
	position += _velocity * delta


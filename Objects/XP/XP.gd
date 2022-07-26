extends Area2D

export var value : int = 1

const DRAG := 14.0
var max_speed := 400.0

var _velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
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

func _on_XP_body_entered(body):
	Game.add_xp(value)
	queue_free()

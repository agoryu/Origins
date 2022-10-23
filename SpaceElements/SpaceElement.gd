extends KinematicBody2D

class_name SpaceElement

export var speed = 1000.0
export var drag := 4.0
export var damage_caused : int = 1
export var priority_target = 0

onready var _collision: CollisionShape2D = $CollisionShape2D
onready var _damage_constructor = preload("res://UI/Damage/Damage.tscn")

var _velocity = Vector2.ZERO

func impact_damage(value_of_damage: int):
	pass
	
func move_in_direction(direction: Vector2):
	var desired_velocity = direction * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / drag
	_velocity = _velocity.clamped(speed)
	_velocity = move_and_slide(_velocity)
	
func display_damage(value: int):
	var damage_label = _damage_constructor.instance()
	damage_label.set_label(value)
	damage_label.global_position = global_position
	damage_label.set_as_toplevel(true)
	get_parent().add_child(damage_label)

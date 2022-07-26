extends RigidBody2D

class_name Character

onready var life = $Life

func _on_Character_body_entered(body):
	life.value -= 1

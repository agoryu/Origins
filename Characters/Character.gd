extends RigidBody2D

class_name Character

onready var life = $Life
onready var energy_consume = 1

func _on_Character_body_entered(body):
	life.value -= 1
	
func impact_damage(damage: int):
	life.value -= damage

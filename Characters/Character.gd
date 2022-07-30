extends RigidBody2D

class_name Character

onready var sprite_texture
onready var life = $Life
onready var energy_consume = 1
onready var energy_reserve = 1
onready var damage_added = 0

func _on_Character_body_entered(body):
	life.value -= 1
	
func impact_damage(damage_impact: int):
	life.value -= damage_impact
	
func add_damage(value: int):
	damage_added += value

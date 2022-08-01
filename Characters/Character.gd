extends RigidBody2D

class_name Character

onready var sprite_texture
onready var life: ProgressBar = null
onready var energy_consume = 1
onready var energy_reserve = 1
onready var damage_added = 0

func _on_Character_body_entered(body):
	life.value -= 1
	Game.shake_screen()
	
func impact_damage(damage_impact: int):
	life.value -= damage_impact
	
func add_damage(value: int):
	damage_added += value
	
func reduce_energy_consume(value: int):
	energy_consume = energy_consume - value if energy_consume - value > 0 else 1

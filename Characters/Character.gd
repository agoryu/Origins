extends RigidBody2D

class_name Character

onready var life: ProgressBar = null
onready var shield: Shield = null
var damage_added = 0

func _on_Character_body_entered(body):
	var shield_value = shield.shield_bar.value
	if shield_value != 0:
		shield_value -= body.damaged_caused
		if shield_value <= 0:
			life.value -= shield_value
			shield.set_values(0, 0)
		else:
			shield.shield_bar.value = shield_value
			shield.show_shield_bar()
	else:
		life.value -= body.damaged_caused
	Game.shake_screen()

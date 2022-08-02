extends Character

class_name Enemy

onready var xp_constructor = preload("res://Objects/XP/XP.tscn")
onready var explosion_constructor = preload("res://Effects/Explosion/Explosion.tscn")

export var damaged_caused = 1

func dead():
	get_xp()
	explose()
	queue_free()

func get_xp():
	var xp = xp_constructor.instance()
	xp.global_position = self.global_position
	get_tree().root.add_child(xp)
	
func explose():
	var explosion = explosion_constructor.instance()
	explosion.global_position = self.global_position
	get_tree().root.add_child(explosion)
	
func impact_damage(damage_impact: int):
	life.value -= damage_impact


extends Character

signal update_shield

var sprite_texture = null
export var energy_consume = 1
export var energy_reserve = 1

func add_damage(value: int):
	damage_added += value
	
func reduce_energy_consume(value: int):
	if energy_consume - value > 0:
		energy_consume -= value
	else:
		energy_consume = 1

func add_shield_value(value: int):
	shield.shield_bar.max_value += value
	shield.shield_bar.value += value
	shield.visible = true

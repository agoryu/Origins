extends "res://SpaceElements/SpaceElement.gd"

class_name Character

onready var _life: SpaceProgressBar = $Life
onready var _shield: Shield = $Shield
onready var _sprite: Sprite = $Sprite
onready var _sprite_texture = $Sprite.texture
onready var _weapon: Node2D = null

var damage_added = 0

func impact_damage(value: int):
	collision_body(value)

func collision_body(value_of_damage: int):
	var shield_value = _shield.shield_bar.value
	if shield_value != 0:
		shield_value -= value_of_damage
		if shield_value <= 0:
			_life.value -= shield_value
			_shield.set_values(0, 0)
		else:
			_shield.shield_bar.value = shield_value
			_shield.show_shield_bar()
	else:
		_life.value -= value_of_damage
	
func move_in_direction(direction: Vector2):
	.move_in_direction(direction)
	
	_sprite.rotation = _velocity.angle() + PI / 2
	if _weapon:
		_weapon.rotation = _sprite.rotation

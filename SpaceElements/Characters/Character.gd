extends SpaceElement

class_name Character

onready var _life: SpaceProgressBar = $CommonShipNode/Life
onready var _shield: Shield = $CommonShipNode/Shield
onready var _sprite: Sprite = $Sprite
onready var _weapon: Node2D = null
onready var _fire: Node2D = $Sprite/Fire

var damage_added = 0
var fire_scale = 1.0
var wait_collision = 0

const WAIT_COLLISION_TIME = 10

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
	else:
		_life.value -= value_of_damage
	
func move_in_direction(direction: Vector2):
	.move_in_direction(direction)
	if get_slide_count() <= 0 and wait_collision <= 0:
		_sprite.rotation = _velocity.angle() + PI / 2
		_collision.rotation = _velocity.angle() + PI / 2
		if _weapon:
			_weapon.rotation = _sprite.rotation
	elif get_slide_count() >= 0 and wait_collision <= 0:
		wait_collision = WAIT_COLLISION_TIME
	else:
		wait_collision -= 1
	if _fire and speed > 0:
		for fire in _fire.get_children():
			var speed_rate : float = _velocity.length() / speed
			fire.scale = Vector2.ONE * speed_rate * 0.2 * fire_scale

extends Button

class_name PowerUpCard

signal close_menu

onready var picture: NinePatchRect = $HBoxContainer/Picture
onready var description: Label = $HBoxContainer/Text

var powerup: GlobalSpecResource = null
var sub_powerup: GlobalSpecResource = null
var value: int = 0
var ship: Ally = null

var override_style = get_stylebox("normal").duplicate()
var override_style_focus = get_stylebox("focus").duplicate()

func _ready():
	add_stylebox_override("normal", override_style)
	add_stylebox_override("focus", override_style_focus)

func _on_PowerUpCard_button_up():
	match powerup.powerup_type:
		SpecPowerUpResource.POWERUP_TYPE.ADD_SHIP:
			var ship = sub_powerup.ship_scene.instance()
			Game.player.add_ally(ship)
		SpecPowerUpResource.POWERUP_TYPE.ENERGY_UP:
			Game.add_max_energy(value)
		SpecPowerUpResource.POWERUP_TYPE.CUSTOM_SHIP:
			match sub_powerup.custom_ship_type:
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.ADD_SHIELD:
					ship.add_shield_value(value)
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_LIFE:
					ship._life.max_value += value
					ship._life.value += value
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_WEAPON:
					ship.add_damage(value)
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
					ship.reduce_energy_consume(value)
	emit_signal("close_menu")

func set_rarity(color: Color):
	override_style.border_color = color
	override_style_focus.border_color = color

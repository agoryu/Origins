extends Button

class_name CustomCard

signal custom_selected

var _icon : NinePatchRect = null
var _ship_type : NinePatchRect = null
var _value_label : Label = null

var ship_type = ""
var value: int = 0 setget set_value
var custom_type

var override_style = get_stylebox("normal").duplicate()
var override_style_focus = get_stylebox("focus").duplicate()

func _ready():
	add_stylebox_override("normal", override_style)
	add_stylebox_override("focus", override_style_focus)
	
func _init():
	_icon = $VBox/HBox/Icon
	_ship_type = $VBox/HBox/ShipType
	_value_label = $VBox/Value

func set_rarity(color: Color):
	override_style.border_color = color
	override_style_focus.border_color = color
	override_style.bg_color = color
	override_style.bg_color.a = 0.5
	override_style_focus.bg_color = color
	override_style_focus.bg_color.a = 0.5

func set_value(new_value: int):
	value = new_value
	_value_label.text = " + " + String(new_value)

func _on_Card_button_up():
	for ship in get_tree().get_nodes_in_group(ship_type):
		match custom_type:
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.ADD_SHIELD:
				ship.add_shield_value(value)
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_LIFE:
				ship._life.max_value += value
				ship._life.value += value
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_WEAPON:
				ship.add_damage(value)
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
				ship.reduce_energy_consume(value)
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.SPEED:
				ship.speed += value
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.COOLDOWN:
				ship.shoot_timer.wait_time -= float(value) / 100.0
	emit_signal("custom_selected")

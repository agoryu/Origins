extends Button

class_name CustomCard

signal custom_selected

onready var _icon : NinePatchRect = $VBox/HBox/Icon
onready var _ship_type : NinePatchRect = $VBox/HBox/ShipType
onready var _value_label : Label = $VBox/Value
onready var _description : Label = $VBox/Description

var ship_type = ""
var value: int = 0
var custom_type

var override_style = get_stylebox("normal").duplicate()
var override_style_focus = get_stylebox("focus").duplicate()

func _ready():
	add_stylebox_override("normal", override_style)
	add_stylebox_override("focus", override_style_focus)

func set_value(new_value: int, value_sign: String):
	value = new_value
	_value_label.text = value_sign + String(new_value)

func _on_Card_button_up():
	for ship in get_tree().get_nodes_in_group(ship_type):
		if custom_type == SpecCustomShipResource.CUSTOM_SHIP_TYPE.ADD_SHIELD:
			ship.add_shield_value(value)
		if not ship.is_max_lvl():
			match custom_type:	
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_LIFE:
					ship._life.max_value += value
					ship._life.value += value
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_WEAPON:
					ship.add_damage(value)
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
					ship.reduce_energy_consume(value)
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.SPEED:
					ship.set_speed(value)
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.COOLDOWN:
					ship.set_cooldown(ship.shoot_timer.wait_time - float(value) / 100.0)
			ship.lvl_up()
	emit_signal("custom_selected")
	
func set_rarity(color: Color):
	override_style.border_color = color
	override_style.bg_color = color
	override_style.bg_color.a = 0.5
	override_style_focus.bg_color = color
	override_style_focus.bg_color.a = 0.5


func _on_Card_focus_entered():
	$AudioStreamPlayer.play()

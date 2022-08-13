extends HBoxContainer

class_name CustomCard

var icon = null
var value_label = null

var ship: Ally = null
var value: int = 0 setget set_value

func _init():
	icon = $Icon
	value_label = $Value

func set_value(new_value: int):
	value = new_value
	value_label.text = String(new_value)

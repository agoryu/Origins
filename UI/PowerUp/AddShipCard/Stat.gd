extends HBoxContainer

onready var _icon = $CenterContainer/Icon
onready var _value_label = $Value 

export var texture : Resource = null setget set_texture
export var value : float = 0 setget set_value

func _ready():
	_icon.texture = texture

func set_texture(texture_stat):
	texture = texture_stat
	
func set_value(value_stat):
	value = value_stat
	_value_label.text = String(value)

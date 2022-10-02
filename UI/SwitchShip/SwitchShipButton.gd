extends Button

onready var _texture = $Box/NinePatchRect

func set_texture(texture):
	_texture.texture = texture

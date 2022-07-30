extends Button

class_name PowerUpCard

onready var picture: NinePatchRect = $HBoxContainer/Picture
onready var description: Label = $HBoxContainer/Text

var powerup: Resource = null

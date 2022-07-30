extends Button

class_name PowerUpCard

onready var picture: NinePatchRect = $HBoxContainer/Picture
onready var description: Label = $HBoxContainer/Text

var powerups: Array = []

func _on_PowerUpCard_button_up():
	if powerups[0].powerup_type == SpecPowerUpResource.POWERUP_TYPE.ADD_SHIP:
		var ship = powerups[1].ship_scene.instance()
		Game.player.add_ally(ship)
	elif powerups[0].powerup_type == SpecPowerUpResource.POWERUP_TYPE.ENERGY_UP:
		Game.add_max_energy(int(powerups[0].text))

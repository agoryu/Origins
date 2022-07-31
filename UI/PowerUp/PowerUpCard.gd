extends Control

signal close_menu

class_name PowerUpCard

onready var picture: NinePatchRect = $PowerUpCardButton/HBoxContainer/Picture
onready var description: Label = $PowerUpCardButton/HBoxContainer/Text
onready var animation_player = $PowerUpCardButton/AnimationPlayer

var powerups: Array = []

func _on_PowerUpCardButton_button_up():
	match powerups[0].powerup_type:
		SpecPowerUpResource.POWERUP_TYPE.ADD_SHIP:
			var ship = powerups[1].ship_scene.instance()
			Game.player.add_ally(ship)
		SpecPowerUpResource.POWERUP_TYPE.ENERGY_UP:
			Game.add_max_energy(int(powerups[0].text))
		SpecPowerUpResource.POWERUP_TYPE.CUSTOM_SHIP:
			match powerups[1].custom_ship_type:
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.ADD_SHIELD:
					pass
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_LIFE:
					powerups[1].ship.life.max_value += powerups[1].value
					powerups[1].ship.life.value += powerups[1].value
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_WEAPON:
					powerups[1].ship.damage += powerups[1].value
				SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
					powerups[1].ship.reduce_energy_consume(powerups[1].value)
	emit_signal("close_menu")

func _on_PowerUpCardButton_focus_entered():
	animation_player.play("selected")

func _on_PowerUpCardButton_focus_exited():
	animation_player.play("deselected")

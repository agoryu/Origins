extends Control

signal close_menu

class_name PowerUpCard

onready var picture: NinePatchRect = $PowerUpCardButton/HBoxContainer/Picture
onready var description: Label = $PowerUpCardButton/HBoxContainer/Text
onready var animation_player = $PowerUpCardButton/AnimationPlayer
onready var rarity = $PowerUpCardButton/Rarity

var powerup: GlobalSpecResource = null
var sub_powerup: GlobalSpecResource = null
var value: int = 0
var ship: Ally = null

func _on_PowerUpCardButton_button_up():
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

func _on_PowerUpCardButton_focus_entered():
	animation_player.play("selected")

func _on_PowerUpCardButton_focus_exited():
	animation_player.play("deselected")

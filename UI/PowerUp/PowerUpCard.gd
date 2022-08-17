extends Button

class_name PowerUpCard

signal close_menu

var powerup: GlobalSpecResource = null
var sub_powerup: GlobalSpecResource = null

var override_style = get_stylebox("normal").duplicate()
var override_style_focus = get_stylebox("focus").duplicate()

func _ready():
	add_stylebox_override("normal", override_style)
	add_stylebox_override("focus", override_style_focus)

func _on_PowerUpCard_button_up():
	release_focus()
	match powerup.powerup_type:
		SpecPowerUpResource.POWERUP_TYPE.ADD_SHIP:
			add_ship()
		SpecPowerUpResource.POWERUP_TYPE.ENERGY_UP:
			var card = get_child(0) as EnergyCard
			FleetManager.add_max_energy(card.value)
		SpecPowerUpResource.POWERUP_TYPE.CUSTOM_SHIP:
			var card = (get_child(0) as CustomCard)
			var value = card.value
			var ship = card.ship
			ship.animation_player.stop()
			ship.animation_player.play("RESET")
			print("RESET VALIDATION")
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
	
func add_ship():
	var card = (get_child(0) as AddShipCard)
	var ship = sub_powerup.ship_scene.instance() as Ally
	FleetManager.add_ally(ship)
	ship._life.max_value = int(card._life.text)
	ship._life.value = int(card._life.text)
	ship.damage_caused = int(card._weapon.text)
	ship.energy_reserve = int(card._energy.text)
	ship.energy_consume = int(card._energy_consume.text)
	ship.speed = int(card._speed.text)
	ship.cooldown = int(card._cooldown.text)

func _on_PowerUpCard_focus_entered():
	var child = get_child(0)
	if child.is_in_group("custom") and (child as CustomCard).ship != null:
		(child as CustomCard).ship.animation_player.play("blink")
		print("BLINK")

func _on_PowerUpCard_focus_exited():
	var child = get_child(0)
	if child.is_in_group("custom") and (child as CustomCard).ship != null:
		(child as CustomCard).ship.animation_player.stop()
		(child as CustomCard).ship.animation_player.play("RESET")
		print("RESET FOCUS")

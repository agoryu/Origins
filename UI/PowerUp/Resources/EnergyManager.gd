extends GlobalManager

class_name EnergyManager


var powerup_resources: Array = [
	preload("res://UI/PowerUp/Resources/PowerUpResources/AddShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/CustomShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/EnergyUp.tres")
]

func add_energy_up(card: PowerUpCard):
	card.picture.texture = card.powerup.image
	card.value = randi() % 51 + 50
	card.description.text = card.powerup.text % [card.value]
	card.set_rarity(calculate_color_rarity(
		(calculate_score_value(card.value, 50, 100) + card.powerup.rarity) / 2
	))

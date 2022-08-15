extends GlobalManager

class_name EnergyManager

func add_energy_up(card: PowerUpCard, card_child: EnergyCard):
	card_child.value = randi() % 51 + 50
	card.set_rarity(calculate_color_rarity(
		(calculate_score_value(card_child.value, 50, 100) + card.powerup.rarity) / 2
	))

extends GlobalManager

class_name AddShipManager

var ship_resources: Array = [
	preload("res://UI/PowerUp/Resources/ShipResources/Enterprise.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/XWing.tres")
]

var ship_tab = []

func _init():
	for ship_resource in ship_resources:
		for i in range(nb_rarity - ship_resource.rarity):
			ship_tab.push_back(ship_resource)

func add_ship_card(card: PowerUpCard):
	var ship_index = randi() % ship_tab.size()
	var ship = ship_tab[ship_index] as SpecShipResources
	card.sub_powerup = ship
	card.picture.texture = ship.image
	card.description.text = ship.name
	card.set_rarity(calculate_color_rarity(ship.rarity))

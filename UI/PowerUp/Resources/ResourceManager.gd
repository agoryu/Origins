extends GlobalManager

var _add_ship_manager = AddShipManager.new()
var _custom_ship_manager = CustomShipManager.new()

var powerup_resources: Array = [
	preload("res://UI/PowerUp/Resources/PowerUpResources/AddShip.tres")
#	preload("res://UI/PowerUp/Resources/PowerUpResources/CustomShip.tres")
]

var powerup_tab = []

# Init tab with resource with N entry. N = rarity
func _init():
	for powerup_resource in powerup_resources:
		for i in range(nb_rarity - powerup_resource.rarity):
			powerup_tab.push_back(powerup_resource)

# Get a powerup and randomize value
func get_card(fleet: Array, tree, card_box) -> Control:
	var powerup_index = randi() % powerup_tab.size()
	var powerup = powerup_tab[powerup_index]
	var card = powerup.card.instance()
	card_box.add_child(card)
	randomize_value(card, fleet, tree)
	return card

# Randomize value of card
func randomize_value(card: Button, fleet: Array, tree):
	if card is CustomCard:
		if not randomize_custom_ship(card, fleet, tree):
			randomize_add_ship(card, fleet)
	if card is AddShipCard:
			randomize_add_ship(card, fleet)
#
func randomize_add_ship(card: AddShipCard, fleet: Array):
	_add_ship_manager.add_ship_card(card, fleet)
	
func randomize_custom_ship(card: CustomCard, fleet: Array, tree) -> bool:
	return _custom_ship_manager.add_custom_card(card, fleet, tree)

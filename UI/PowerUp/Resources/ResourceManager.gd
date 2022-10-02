extends GlobalManager

var _add_ship_manager = AddShipManager.new()
var _custom_ship_manager = CustomShipManager.new()

var powerup_resources: Array = [
	preload("res://UI/PowerUp/Resources/PowerUpResources/AddShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/CustomShip.tres")
]

var powerup_tab = []

# Init tab with resource with N entry. N = rarity
func _init():
	for powerup_resource in powerup_resources:
		for i in range(nb_rarity - powerup_resource.rarity):
			powerup_tab.push_back(powerup_resource)

# Get a powerup and randomize value
func get_card(tree, card_box) -> Control:
	var powerup_index = randi() % powerup_tab.size()
	var powerup = powerup_tab[powerup_index]
	var card = powerup.card.instance()
	card_box.add_child(card)
	if not randomize_value(card, tree):
		card.queue_free()
		var new_card = powerup_tab[0].card.instance()
		card_box.add_child(new_card)
		randomize_value(new_card, tree)
		return new_card
	return card

# Randomize value of card
func randomize_value(card: Button, tree) -> bool:
	if card is CustomCard:
		return randomize_custom_ship(card, tree)
	if card is AddShipCard:
		randomize_add_ship(card, tree)
	return true
#
func randomize_add_ship(card: AddShipCard, tree):
	_add_ship_manager.add_ship_card(card, tree)
	
func randomize_custom_ship(card: CustomCard, tree) -> bool:
	return _custom_ship_manager.add_custom_card(card, tree)

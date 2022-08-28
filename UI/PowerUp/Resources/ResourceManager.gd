extends GlobalManager

var _add_ship_manager = AddShipManager.new()
var _custom_ship_manager = CustomShipManager.new()
var _energy_up_manager = EnergyManager.new()

var powerup_resources: Array = [
#	preload("res://UI/PowerUp/Resources/PowerUpResources/AddShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/CustomShip.tres")
#	preload("res://UI/PowerUp/Resources/PowerUpResources/EnergyUp.tres")
]

var powerup_tab = []

# Init tab with resource with N entry. N = rarity
func _init():
	for powerup_resource in powerup_resources:
		for i in range(nb_rarity - powerup_resource.rarity):
			powerup_tab.push_back(powerup_resource)

# Get a powerup and randomize value
func get_card(fleet: Array, tree) -> Control:
	var powerup_index = randi() % powerup_tab.size()
	var powerup = powerup_tab[powerup_index]
	var card = powerup.card.instance()
	card._init()
	randomize_value(card, fleet, tree)
	return card

# Randomize value of card
func randomize_value(card: Button, fleet: Array, tree):
	if card is CustomCard:
		if not randomize_custom_ship(card, fleet, tree):
			pass
			# randomize ship
#	card.powerup.POWERUP_TYPE.ADD_SHIP:
#			randomize_add_ship(card, card_child as AddShipCard, fleet)
#		card.powerup.POWERUP_TYPE.CUSTOM_SHIP:
#			randomize_custom_ship(card, card_child as CustomCard, fleet)
#		card.powerup.POWERUP_TYPE.ENERGY_UP:
#			randomize_energy_up(card, card_child as EnergyCard)
#
func randomize_add_ship(card: PowerUpCard, card_child: AddShipCard, fleet: Array):
	_add_ship_manager.add_ship_card(card, card_child, fleet)
	
func randomize_custom_ship(card: CustomCard, fleet: Array, tree) -> bool:
	return _custom_ship_manager.add_custom_card(card, fleet, tree)
	
func randomize_energy_up(card: PowerUpCard, card_child: EnergyCard):
	_energy_up_manager.add_energy_up(card, card_child)

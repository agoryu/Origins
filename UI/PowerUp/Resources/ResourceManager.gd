extends GlobalManager

var _add_ship_manager = AddShipManager.new()
var _custom_ship_manager = CustomShipManager.new()
var _energy_up_manager = EnergyManager.new()

var powerup_resources: Array = [
	preload("res://UI/PowerUp/Resources/PowerUpResources/AddShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/CustomShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/EnergyUp.tres")
]

var powerup_tab = []

# Init tab with resource with N entry. N = rarity
func _init():
	for powerup_resource in powerup_resources:
		for i in range(nb_rarity - powerup_resource.rarity):
			powerup_tab.push_back(powerup_resource)

# Get a powerup and randomize value
func update_card(card: PowerUpCard, fleet: Array):
	var powerup_index = randi() % powerup_tab.size()
	var powerup = powerup_tab[powerup_index]
	card.powerup = powerup
	randomize_value(card, fleet)

# Randomize value of card
func randomize_value(card: PowerUpCard, fleet: Array):
	match card.powerup.powerup_type:
		card.powerup.POWERUP_TYPE.ADD_SHIP:
			randomize_add_ship(card)
		card.powerup.POWERUP_TYPE.CUSTOM_SHIP:
			randomize_custom_ship(card, fleet)
		card.powerup.POWERUP_TYPE.ENERGY_UP:
			randomize_energy_up(card)
			
func randomize_add_ship(card: PowerUpCard):
	_add_ship_manager.add_ship_card(card)
	
func randomize_custom_ship(card: PowerUpCard, fleet: Array):
	_custom_ship_manager.add_custom_card(card, fleet)
	
func randomize_energy_up(card: PowerUpCard):
	_energy_up_manager.add_energy_up(card)

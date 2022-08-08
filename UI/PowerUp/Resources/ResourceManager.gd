extends Node

var powerup_resources: Array = [
	preload("res://UI/PowerUp/Resources/PowerUpResources/AddShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/CustomShip.tres"),
	preload("res://UI/PowerUp/Resources/PowerUpResources/EnergyUp.tres")
]

var ship_resources: Array = [
	preload("res://UI/PowerUp/Resources/ShipResources/Enterprise.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/XWing.tres")
]

var custom_ship_resources: Array = [
	preload("res://UI/PowerUp/Resources/CustomShipResources/AddShield.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/BoostLife.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/BoostWeapon.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/ReduceEnergyConsume.tres")
]

var powerup_tab = []
var ship_tab = []
var custom_ship_tab = []

var nb_rarity = 0

# Init tab with resource with N entry. N = rarity
func _init():
	nb_rarity = GlobalSpecResource.RARITY.size()
	print("Rarity size : " + String(nb_rarity))
	for powerup_resource in powerup_resources:
		print("Rarity powerup : " + String(powerup_resource.rarity) + " present " + String(nb_rarity - powerup_resource.rarity))
		for i in range(nb_rarity - powerup_resource.rarity):
			powerup_tab.push_back(powerup_resource)
			
	for ship_resource in ship_resources:
		print("Rarity ship : " + String(ship_resource.rarity) + " present " + String(nb_rarity - ship_resource.rarity))
		for i in range(nb_rarity - ship_resource.rarity):
			ship_tab.push_back(ship_resource)
	
	for custom_ship_resource in custom_ship_resources:
		print("Rarity custom : " + String(custom_ship_resource.rarity) + " present " + String(nb_rarity - custom_ship_resource.rarity))
		for i in range(nb_rarity - custom_ship_resource.rarity):
			custom_ship_tab.push_back(custom_ship_resource)

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
	var ship_index = randi() % ship_tab.size()
	var ship = ship_tab[ship_index] as SpecShipResources
	card.sub_powerup = ship
	card.picture.texture = ship.image
	card.description.text = ship.name
	card.rarity.color = calculate_color_rarity(ship.rarity)
	
func randomize_custom_ship(card: PowerUpCard, fleet: Array):
	var is_valid_ship = false
	var ship: Ally = null
	while not is_valid_ship:
		var ship_index = randi() % fleet.size()
		if is_instance_valid(fleet[ship_index]):
			ship = fleet[ship_index] as Character
			is_valid_ship = true
		else:
			fleet.remove(ship_index)
	
	var custom_ship_index = randi() % custom_ship_tab.size()
	var custom_ship = custom_ship_tab[custom_ship_index] as SpecCustomShipResource
	
	if custom_ship.custom_ship_type == SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
		pass
	
	var custom_value = randi() % custom_ship.max_value + custom_ship.min_value
	#TODO relance action if maximum reach
	card.picture.texture = ship._sprite_texture
	card.description.text = custom_ship.text % [custom_value]
	card.sub_powerup = custom_ship
	var global_rarity = (calculate_score_value(
		custom_value, 
		custom_ship.min_value, 
		custom_ship.max_value
	) + card.powerup.rarity + custom_ship.rarity) / 3
	
	card.rarity.color  = calculate_color_rarity(custom_value)
	card.value = custom_value
	card.ship = ship
	
func randomize_energy_up(card: PowerUpCard):
	card.picture.texture = card.powerup.image
	card.value = randi() % 51 + 50
	card.description.text = card.powerup.text % [card.value]
	card.rarity.color  = calculate_color_rarity(
		(calculate_score_value(card.value, 50, 100) + card.powerup.rarity) / 2
	)

# Calculate score for determination of rarity of object
func calculate_score_value(value_bonus: float, min_value: float, max_value: float) -> int:
	var step = (max_value - min_value) / float(GlobalSpecResource.RARITY.size())
	print("Step : " + String(step))
	for i in nb_rarity - 1:
		print("Bonus : " + String(value_bonus) + " > " + String(min_value + ((nb_rarity - i - 1) * step)))
		if value_bonus >= min_value + ((nb_rarity - i) * step):
			print("Score value : " + String(i))
			return nb_rarity - i - 1
	print("Score value 0")
	return 0
			
func calculate_color_rarity(rarity: int) -> Color:
	match rarity:
		GlobalSpecResource.RARITY.COMMON:
			return Color("#179cd0")
		GlobalSpecResource.RARITY.RARE:
			return Color("#3fd017")
		GlobalSpecResource.RARITY.SUPER_RARE:
			return Color("#d0c917")
		GlobalSpecResource.RARITY.EXTRAORDINARY:
			return Color("#d07b17")
		GlobalSpecResource.RARITY.LEGENDARY:
			return Color("#9755da")
	return Color(1)

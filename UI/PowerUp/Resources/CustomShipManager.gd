extends GlobalManager

class_name CustomShipManager

var custom_ship_resources: Array = [
#	preload("res://UI/PowerUp/Resources/CustomShipResources/AddShield.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/BoostLife.tres")
#	preload("res://UI/PowerUp/Resources/CustomShipResources/BoostWeapon.tres"),
#	preload("res://UI/PowerUp/Resources/CustomShipResources/ReduceEnergyConsume.tres")
]

var custom_ship_tab = []

func _init():
	for custom_ship_resource in custom_ship_resources:
		for i in range(nb_rarity - custom_ship_resource.rarity):
			custom_ship_tab.push_back(custom_ship_resource)
			
func add_custom_card(card: CustomCard, fleet: Array, tree):
	var is_valid_custom : bool = false
	var custom_ship_index = 0
	var custom_ship : SpecCustomShipResource = null
	var custom_value = 0
	var ship : Ally = null
	
	while not is_valid_custom:
		ship = _get_ship(fleet)
		custom_ship_index = randi() % custom_ship_tab.size()
		custom_ship = custom_ship_tab[custom_ship_index] as SpecCustomShipResource
		custom_value = randi() % (1 + custom_ship.max_value - custom_ship.min_value) + custom_ship.min_value
		is_valid_custom = _is_valid_customization(ship.first_group, custom_ship, custom_value, tree)
	
	card._icon.texture = custom_ship.icon
	card._ship_type.texture = ship._sprite.texture
	card.custom_type = custom_ship.custom_ship_type
	var global_rarity = calculate_score_value(
		custom_value, 
		custom_ship.min_value, 
		custom_ship.max_value
	)
	card.set_rarity(calculate_color_rarity(global_rarity))
	card.value = custom_value
	card.ship_type = ship.first_group

func _get_ship(fleet : Array) -> Ally:
	var is_valid_ship = true
	while is_valid_ship:
		var ship_index = randi() % fleet.size()
		var ship = fleet[ship_index] as Ally
		if is_instance_valid(ship) and ship.lvl < ship.MAX_LVL:
			return ship
		else:
			fleet.remove(ship_index)
		is_valid_ship = fleet.size() > 0
	return null
	
func _is_valid_customization(
	ship_type: String, 
	customization: SpecCustomShipResource, value: int,
	tree
) -> bool:
	var ship_in_group = tree.get_nodes_in_group(ship_type)
	for ship in ship_in_group:
		match customization.custom_ship_type:
#			SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
#				return ship.energy_consume >= ship.min_energy_consume
#			SpecCustomShipResource.CUSTOM_SHIP_TYPE.ADD_SHIELD:
#				return true
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_LIFE:
				if ship._life.value + value > ship.max_life:
					return false
#			SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_WEAPON:
#				return ship.damage_added + value <= ship.max_damage
	return true

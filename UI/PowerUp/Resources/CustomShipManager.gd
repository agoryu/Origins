extends GlobalManager

class_name CustomShipManager

var custom_ship_resources: Array = [
	preload("res://UI/PowerUp/Resources/CustomShipResources/AddShield.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/BoostLife.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/BoostWeapon.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/ReduceEnergyConsume.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/Speed.tres"),
	preload("res://UI/PowerUp/Resources/CustomShipResources/Cooldown.tres")
]

var custom_ship_tab = []
const MAX_SEARCH = 10

func _init():
	for custom_ship_resource in custom_ship_resources:
		for i in range(nb_rarity - custom_ship_resource.rarity):
			custom_ship_tab.push_back(custom_ship_resource)
			
func add_custom_card(card: CustomCard, fleet: Array, tree) -> bool:
	var is_valid_custom : bool = false
	var nb_search = 0
	var custom_ship_index = 0
	var custom_ship : SpecCustomShipResource = null
	var custom_value = 0
	var ship : Ally = null
	
	while not is_valid_custom:
		ship = _get_ship(fleet)
		if ship == null:
			return false
		custom_ship_index = randi() % custom_ship_tab.size()
		custom_ship = custom_ship_tab[custom_ship_index] as SpecCustomShipResource
		custom_value = randi() % (1 + custom_ship.max_value - custom_ship.min_value) + custom_ship.min_value
		is_valid_custom = _is_valid_customization(ship.first_group, custom_ship, custom_value, tree)
		if not is_valid_custom:
			if nb_search + 1 > MAX_SEARCH:
				return false
			else:
				nb_search += 1
	
	card._icon.texture = custom_ship.icon
	card._ship_type.texture = ship._sprite.texture
	card.custom_type = custom_ship.custom_ship_type
	card._description.text = custom_ship.description
	var global_rarity = (calculate_score_value(
		custom_value, 
		custom_ship.min_value, 
		custom_ship.max_value
	) + custom_ship.rarity) / 2
	card.set_rarity(calculate_color_rarity(global_rarity))
	card.value = custom_value
	card.ship_type = ship.first_group
	return true

func _get_ship(fleet : Array) -> Ally:
	var is_valid_ship = true
	while is_valid_ship:
		var ship_index = randi() % fleet.size()
		var ship = fleet[ship_index]
		if is_instance_valid(ship) and (ship as Ally).lvl < ship.MAX_LVL:
			return ship as Ally
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
		if customization.custom_ship_type == SpecCustomShipResource.CUSTOM_SHIP_TYPE.ADD_SHIELD:
			return true
		if ship.lvl > ship.MAX_LVL:
			return false
		match customization.custom_ship_type:
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.REDUCE_ENERGY_CONSUME:
				if ship.energy_consume - value < ship.min_energy_consume:
					return false
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_LIFE:
				if ship._life.max_value + value > ship.max_life:
					return false
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.BOOST_WEAPON:
				if ship.damage_added + value > ship.max_damage:
					return false
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.SPEED:
				if ship.speed + value > ship.max_speed:
					return false
			SpecCustomShipResource.CUSTOM_SHIP_TYPE.COOLDOWN:
				if ship.shoot_timer.wait_time - value / 100.0 < ship.min_cooldown:
					return false
	return true

extends GlobalManager

class_name AddShipManager

var ship_resources: Array = [
	preload("res://UI/PowerUp/Resources/ShipResources/Viper.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/Enterprise.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/RadarShip.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/XWing.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/Cargo.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/Samus.tres")
]

var ship_tab = []

func _init():
	for ship_resource in ship_resources:
		for i in range(nb_rarity - ship_resource.rarity):
			ship_tab.push_back(ship_resource)

func add_ship_card(card: AddShipCard, tree):
	var is_valid_ship : bool = false
	var ship: SpecShipResources = null
	
	while not is_valid_ship:
		var ship_index = randi() % ship_tab.size()
		ship = ship_tab[ship_index] as SpecShipResources
		is_valid_ship = check_validity(ship, tree)
		
	card.powerup = ship
	card._icon.texture = ship.image
	var life = randomize_value(ship.life, ship.life_random)
	var weapon = randomize_value(ship.weapon, ship.weapon_random)
	var energy = randomize_value(ship.energy, ship.energy_random)
	var energy_consume = randomize_value(ship.energy_consume, ship.energy_consume_random)
	var speed = randomize_value(ship.speed, ship.speed_random)
	var cooldown = randomize_value_float(ship.cooldown, ship.cooldown_random)
	card.set_ship(life, weapon, energy, energy_consume, speed, cooldown)
	
	var rarity_life = calculate_score_value(life, ship.life - ship.life_random, ship.life + ship.life_random)
	var rarity_weapon = calculate_score_value(weapon, ship.weapon - ship.weapon_random, ship.weapon + ship.weapon_random)
	var rarity_energy = calculate_score_value(energy, ship.energy - ship.energy_random, ship.energy + ship.energy_random)
	var rarity_energy_consume = GlobalSpecResource.RARITY.size() - 2 - calculate_score_value(energy_consume, ship.energy_consume - ship.energy_consume_random, ship.energy_consume + ship.energy_consume_random)
	var rarity_speed = calculate_score_value(speed, ship.speed - ship.speed_random, ship.speed + ship.speed_random)
	var rarity_cooldown = GlobalSpecResource.RARITY.size() - 2 - calculate_score_value(cooldown, ship.cooldown - ship.cooldown_random, ship.cooldown + ship.cooldown_random)
	var rarity = (ship.rarity + rarity_life + rarity_weapon + rarity_energy + rarity_energy_consume +
		rarity_speed + rarity_cooldown) / 7
	card.set_rarity(calculate_color_rarity(rarity), rarity)
	card.apply_rarity_color(rarity_life, card._life._value_label)
	card.apply_rarity_color(rarity_weapon, card._weapon._value_label)
	card.apply_rarity_color(rarity_energy, card._energy._value_label)
	card.apply_rarity_color(rarity_energy_consume, card._energy_consume._value_label)
	card.apply_rarity_color(rarity_speed, card._speed._value_label)
	card.apply_rarity_color(rarity_cooldown, card._cooldown._value_label)
	
func check_validity(ship: SpecShipResources, tree) -> bool:
	var nb_type_ship = tree.get_nodes_in_group(ship.name).size()
	return nb_type_ship < ship.max_ship
	
func randomize_value(value: int, randomness: int) -> int:
	var rand_value = randi() % (((value + randomness) - (value - randomness)) + 1)
	var result = (value - randomness) + rand_value
	return result if result > 0 else 1
	
func randomize_value_float(value: float, randomness: float) -> float:
	value *= 100
	randomness *= 100
	var rand_value = randomize_value(value, randomness)
	return stepify(float(rand_value) / 100.0, 0.01)

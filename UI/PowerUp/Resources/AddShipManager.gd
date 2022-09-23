extends GlobalManager

class_name AddShipManager

var ship_resources: Array = [
	preload("res://UI/PowerUp/Resources/ShipResources/Viper.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/Enterprise.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/RadarShip.tres"),
	preload("res://UI/PowerUp/Resources/ShipResources/XWing.tres")
]

var ship_tab = []

func _init():
	for ship_resource in ship_resources:
		for i in range(nb_rarity - ship_resource.rarity):
			ship_tab.push_back(ship_resource)

func add_ship_card(card: AddShipCard, fleet: Array):
	var is_valid_ship : bool = false
	var ship: SpecShipResources = null
	
	while not is_valid_ship:
		var ship_index = randi() % ship_tab.size()
		ship = ship_tab[ship_index] as SpecShipResources
		is_valid_ship = check_validity(ship, fleet)
		
	card.powerup = ship
	card._icon.texture = ship.image
	var life = randomize_value(ship.life, ship.life_random)
	var weapon = randomize_value(ship.weapon, ship.weapon_random)
	var energy = randomize_value(ship.energy, ship.energy_random)
	var energy_consume = randomize_value(ship.energy_consume, ship.energy_consume_random)
	var speed = randomize_value(ship.speed, ship.speed_random)
	var cooldown = randomize_value_float(ship.cooldown, ship.cooldown_random)
	card.set_ship(life, weapon, energy, energy_consume, speed, cooldown)
	
	var rarity = (
		ship.rarity + 
		calculate_score_value(life, ship.life - ship.life_random, ship.life + ship.life_random) +
		calculate_score_value(life, ship.weapon - ship.weapon_random, ship.weapon + ship.weapon_random) +
		calculate_score_value(life, ship.energy - ship.energy_random, ship.energy + ship.energy_random) +
		calculate_score_value(life, ship.energy_consume - ship.energy_consume_random, ship.energy_consume + ship.energy_consume_random) +
		calculate_score_value(life, ship.speed - ship.speed_random, ship.speed + ship.speed_random) +
		calculate_score_value(life, ship.cooldown - ship.cooldown_random, ship.cooldown + ship.cooldown_random)
	) / 7
	card.set_rarity(calculate_color_rarity(rarity), rarity)
	
func check_validity(ship: SpecShipResources, fleet: Array) -> bool:
	var nb_type_ship = 0
	for ship_fleet in fleet:
		if ship.ship_scene.resource_path == (ship_fleet as Ally).filename:
			nb_type_ship += 1
	return nb_type_ship < ship.max_ship
	
func randomize_value(value: int, randomness: int) -> int:
	var rand_value = randi() % ((value + randomness) - (value - randomness))
	return (value - randomness) + rand_value
	
func randomize_value_float(value: float, randomness: float) -> float:
	var rand_value = fmod(randf(), ((value + randomness) - (value - randomness)))
	return stepify((value - randomness) + rand_value, 0.01)

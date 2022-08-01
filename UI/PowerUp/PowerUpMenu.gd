extends Control

onready var card_box = $CardBox

export var powerup_resources = []
export var ship_resources = []
export var custom_ship_resources = []

var powerup_tab = []
var ship_tab = []
var custom_ship_tab = []

var nb_powerup_elements = 0
var nb_ship_elements = 0
var nb_custom_ship_elements = 0

func _ready():
	create_dictionary()

func create_dictionary():
	for powerup_resource in powerup_resources:
		for i in range(powerup_resource.rarity + 1):
			powerup_tab.push_back(powerup_resource)
	nb_powerup_elements = powerup_tab.size()
	
	for ship_resource in ship_resources:
		for i in range(ship_resource.rarity + 1):
			ship_tab.push_back(ship_resource)
	nb_ship_elements = ship_tab.size()
	
	for custom_ship_resource in custom_ship_resources:
		for i in range(custom_ship_resource.rarity + 1):
			custom_ship_tab.push_back(custom_ship_resource)
	nb_custom_ship_elements = custom_ship_tab.size()

func level_up():
	var fleet = Game.player._fleet_tab + [Game.player]
	for i in range(3):
		var card: PowerUpCard = card_box.get_child(i) as PowerUpCard
		var powerup_index = randi() % nb_powerup_elements
		var powerup = powerup_tab[powerup_index]
		card.powerups.clear()
		card.powerups.push_back(powerup)
		if powerup.powerup_type == SpecPowerUpResource.POWERUP_TYPE.ENERGY_UP:
			manage_energy_up(card, powerup)
		elif powerup.powerup_type == SpecPowerUpResource.POWERUP_TYPE.CUSTOM_SHIP:
			manage_custom_ship(card, powerup, fleet)
		else:
			manage_add_ship(card, powerup)
	card_box.get_child(0).get_node("PowerUpCardButton").grab_focus()

func manage_energy_up(card: PowerUpCard, powerup: Resource):
	card.picture.texture = powerup.image
	var energy_value = randi() % 31 + 20
	powerup.text = String(energy_value)
	card.description.text = powerup.text + " energy added"

func manage_custom_ship(card: PowerUpCard, powerup: Resource, fleet: Array):
	var ship_index = randi() % fleet.size()
	var ship = fleet[ship_index] as Character
	
	var custom_ship_index = randi() % nb_custom_ship_elements
	var custom_ship = custom_ship_tab[custom_ship_index] as SpecCustomShipResource
	
	card.picture.texture = ship.sprite_texture
	var custom_value = randi() % custom_ship.max_value + custom_ship.min_value
	card.description.text = custom_ship.text % [custom_value]
	custom_ship.value = custom_value
	
	card.powerups.push_back(custom_ship)
	custom_ship.ship = ship

func manage_add_ship(card: PowerUpCard, powerup: Resource):
	var ship_index = randi() % nb_ship_elements
	var ship = ship_tab[ship_index]
	card.powerups.push_back(ship)
	card.picture.texture = ship.image
	card.description.text = ship.name

func _on_PowerUpCard_close_menu():
	visible = false
	Game.stop_pause()

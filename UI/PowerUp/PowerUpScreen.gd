extends Control

onready var card_box = $CardBox

export var powerup_resources = []
export var ship_resources = []

var powerup_tab = []
var ship_tab = []
var nb_powerup_elements = 0
var nb_ship_elements = 0

func _ready():
	create_dictionary()

func create_dictionary():
	for powerup_resource in powerup_resources:
		for i in range(powerup_resource.rarity):
			powerup_tab.push_back(powerup_resource)
	nb_powerup_elements = powerup_tab.size()
	
	for ship_resource in ship_resources:
		for i in range(ship_resource.rarity):
			ship_tab.push_back(ship_resource)
	nb_ship_elements = ship_tab.size()

func level_up():
	var fleet = [] #Game.player._fleet_tab
	for i in range(3):
		var card: PowerUpCard = card_box.get_child(i) as PowerUpCard
		var powerup_index = fmod(randi(), nb_powerup_elements)
		var powerup = powerup_tab[powerup_index]
		
		if powerup.powerup_type == "EnergyUp":
			print("+50 energy size")
			card.picture.texture = powerup.image
			card.description.text = powerup.text
		elif powerup.powerup_type == "CustomShip" and fleet.size() > 0:
			print("determine what capacity and ship")
		else:
			var ship_index = fmod(randi(), nb_ship_elements)
			var ship = ship_tab[ship_index]
			print(ship.name)
			card.picture.texture = ship.image
			card.description.text = ship.name
	card_box.get_child(0).grab_focus()

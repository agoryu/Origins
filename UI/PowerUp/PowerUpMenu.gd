extends Control

onready var card_box = $CardBox

var resource_manager = preload("res://UI/PowerUp/Resources/ResourceManager.gd").new()

func level_up():
	var fleet = Game.player._fleet_tab + [Game.player]
	for i in range(3):
		var card: PowerUpCard = card_box.get_child(i) as PowerUpCard
		resource_manager.update_card(card, fleet)
	card_box.get_child(0).get_node("PowerUpCardButton").grab_focus()

#func manage_add_ship(card: PowerUpCard, powerup: Resource):
#	var ship_index = randi() % nb_ship_elements
#	var ship = ship_tab[ship_index]
#	card.powerups.push_back(ship)
#	card.picture.texture = ship.image
#	card.description.text = ship.name

func _on_PowerUpCard_close_menu():
	visible = false
	Game.stop_pause()

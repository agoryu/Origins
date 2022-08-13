extends PanelContainer

signal close_menu

onready var card_box = $CardBox

var resource_manager = preload("res://UI/PowerUp/Resources/ResourceManager.gd").new()

func level_up():
	$AudioStreamPlayer2D.play()
	for i in range(3):
		var card: PowerUpCard = card_box.get_child(i) as PowerUpCard
		if card.get_child(0) != null:
			card.get_child(0).queue_free()
		var child = resource_manager.get_card(card, FleetManager.fleet_tab)
		card.add_child(child)
	card_box.get_child(0).grab_focus()

func _on_PowerUpCard_close_menu():
	emit_signal("close_menu")



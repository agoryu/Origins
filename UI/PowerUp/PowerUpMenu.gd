extends PanelContainer

signal close_menu

onready var card_box = $CardBox

var resource_manager = preload("res://UI/PowerUp/Resources/ResourceManager.gd").new()

func level_up():
	$AudioStreamPlayer2D.play()
	var fleet = Game._fleet_tab + [Game.player]
	for i in range(3):
		var card: PowerUpCard = card_box.get_child(i) as PowerUpCard
		resource_manager.update_card(card, fleet)
	card_box.get_child(0).grab_focus()

func _on_PowerUpCard_close_menu():
	emit_signal("close_menu")



extends PanelContainer

class_name PowerupMenu

onready var _card_box = $VBoxContainer/CardBox
onready var _tween = $Tween

var resource_manager = preload("res://UI/PowerUp/Resources/ResourceManager.gd").new()

var open : bool = false

func level_up():
	$AudioStreamPlayer2D.play()
	animate()
	clear_children()
	for i in range(3):
		var card = resource_manager.get_card(FleetManager.fleet_tab, get_tree(), _card_box)
		card.connect("custom_selected", self, "close_power_up_menu")
		if i == 0:
			card.grab_focus()

func close_power_up_menu():
	Game.stop_pause()
	animate()

func animate():
	open = !open
	if open:
		_tween.interpolate_property(self, "rect_scale", Vector2.ZERO, Vector2.ONE, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.2)
		_tween.start()
	else:
		_tween.interpolate_property(self, "rect_scale", Vector2.ONE, Vector2.ZERO, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.1)
		_tween.start()

func clear_children():
	for child in _card_box.get_children():
		child.queue_free()

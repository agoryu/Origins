extends Control

onready var _switch_left : Button = $SwitchShipButtonLeft
onready var _switch_right : Button = $SwitchShipButtonRight

func _ready():
	FleetManager.connect("set_player", self, "update_button")
	FleetManager.connect("update_allies", self, "update_ship")
	FleetManager.connect("loose_ally", self, "loose_ally")
	
func _unhandled_input(event):
	if event.is_action_pressed("switch_left"):
		_switch_left.grab_focus()
	if event.is_action_pressed("switch_right"):
		_switch_right.grab_focus()
	if event.is_action_released("switch_left"):
		_switch_left.release_focus()
	if event.is_action_released("switch_right"):
		_switch_right.release_focus()
		
	if event.is_action_released("switch_left") or event.is_action_released("switch_right"):
		$AudioStreamPlayer.play()
	
func update_button():
	if FleetManager.fleet_tab.size() <= 0:
		_switch_left.disabled = true
		_switch_right.disabled = true
		return
	else:
		_switch_left.disabled = false
		_switch_right.disabled = false
		
	var index_left = (FleetManager.fleet_tab.find(FleetManager.player) - 1) % FleetManager.fleet_tab.size()
	var index_right = (FleetManager.fleet_tab.find(FleetManager.player) + 1) % FleetManager.fleet_tab.size()
	_switch_left.set_texture((FleetManager.fleet_tab[index_left] as Ally)._sprite.texture)
	_switch_right.set_texture((FleetManager.fleet_tab[index_right] as Ally)._sprite.texture)

func update_ship(vect: Vector2):
	update_button()

func loose_ally(ally):
	update_button()

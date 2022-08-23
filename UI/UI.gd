extends CanvasLayer

onready var _xp_level = $HBoxContainer/VBoxContainer/XPLevel
onready var _warning_level = $HBoxContainer/VBoxContainer/HBoxContainer/WarningLevelValue
onready var _power_up_screen = $PowerUpScreen
onready var _tween = $PowerUpScreen/Tween
onready var _overlay = $Overlay

func _ready():
	Game.connect("update_xp", self, "update_xp")
	Game.connect("level_up", self, "level_up")
	Game.connect("make_pause", self, "make_pause")
	Game.connect("stop_pause", self, "stop_pause")
	_xp_level.max_value = Game.max_xp_value
	
func update_xp(value : int):
	_xp_level.value = value
	
func level_up(value : int, max_value : int, warning_level : int):
	update_xp(value)
	_xp_level.max_value = max_value
	_warning_level.text = String(warning_level)
#	_power_up_screen.level_up()
#	anim_menu(1545, 1075)
#	_overlay.visible = true
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Game.make_pause()
		Game.is_on_pause = true
	elif event.is_action_released("switch_left"):
		FleetManager.switch_ship(-1)
	elif event.is_action_released("switch_right"):
		FleetManager.switch_ship(1)
		
func anim_menu(start_position: int, end_position: int):
	_tween.interpolate_property(
		$PowerUpScreen, 
		"rect_position", 
		Vector2(start_position, 0), 
		Vector2(end_position, 0), 
		1.0, 
		Tween.TRANS_ELASTIC, 
		Tween.EASE_OUT
	)
	_tween.start()

func _on_PowerUpScreen_close_menu():
	anim_menu(1075, 1545)
	_overlay.visible = false
	Game.stop_pause()
	
func make_pause():
	_overlay.visible = true
	
func stop_pause():
	_overlay.visible = false

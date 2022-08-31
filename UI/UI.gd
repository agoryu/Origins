extends CanvasLayer

onready var _xp_level = $HBoxContainer/VBoxContainer/XPLevel
onready var _warning_level = $HBoxContainer/VBoxContainer/HBoxContainer/WarningLevelValue
onready var _power_up_screen = $PowerUpScreen
onready var _overlay = $Overlay
onready var _animation_player = $AnimationPlayer

func _ready():
	Game.connect("update_xp", self, "update_xp")
	Game.connect("level_up", self, "level_up")
	Game.connect("make_pause", self, "make_pause")
	Game.connect("close_menu", self, "stop_pause")
	FleetManager.connect("max_lvl_ship", self, "max_lvl_ship")
	_xp_level.max_value = Game.max_xp_value
	
func update_xp(value : int):
	_xp_level.value = value
	
func level_up(value : int, max_value : int, warning_level : int):
	update_xp(value)
	_xp_level.max_value = max_value
	_warning_level.text = String(warning_level)
	_overlay.visible = true
	_power_up_screen.level_up()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Game.make_pause()
		Game.is_on_pause = true
	elif event.is_action_released("switch_left"):
		FleetManager.switch_ship(-1)
	elif event.is_action_released("switch_right"):
		FleetManager.switch_ship(1)
	
func make_pause():
	_overlay.visible = true
	
func stop_pause():
	_overlay.visible = false

func max_lvl_ship():
	_animation_player.play("unlock_power")

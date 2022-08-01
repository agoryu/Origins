extends CanvasLayer

onready var _xp_level = $XPLevel
onready var _warning_level_value = $VBoxContainer/WarningLevel/WarningLevelValue
onready var _power_up_screen = $PowerUpScreen

func _ready():
	Game.connect("update_xp", self, "update_xp")
	Game.connect("level_up", self, "level_up")
	_xp_level.max_value = Game.max_xp_value
	
func update_xp(value : int):
	_xp_level.value = value
	
func level_up(value : int, max_value : int, warning_level : int):
	update_xp(value)
	_xp_level.max_value = max_value
	_warning_level_value.text = String(warning_level)
	_power_up_screen.visible = true
	_power_up_screen.level_up()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Game.make_pause()

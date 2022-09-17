extends Control

onready var title = $Title
onready var options = $Options
onready var continue_button = $Options/Continue
onready var restart_button = $Options/Restart
onready var play_time = $PlayTime

var time_value = ""

func _ready():
	Game.connect("game_over", self, "make_game_over")
	Game.connect("make_pause", self, "make_pause")
	Game.connect("close_menu", self, "close_menu")
	self.visible = false
	play_time.visible = false

func make_game_over():
	title.text = "Mission Failed"
	continue_button.visible = false
	self.visible = true
	restart_button.grab_focus()
	play_time.visible = true
	$PlayTime/PlayTimeValue.text = time_value
	
func make_pause():
	title.text = "Pause"
	continue_button.grab_focus()
	self.visible = true

func close_menu():
	visible = false

func _on_focus_entered():
	$AudioStreamPlayer2D.play()

func _on_GameTimer_time_over(text: String):
	time_value = text

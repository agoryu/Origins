extends Label

signal time_over

var time := 0.0
var is_playing : bool = true

func _ready():
	Game.connect("game_over", self, "game_over")

func _process(delta):
	if is_playing:
		time += delta
		var sec = fmod(time, 60)
		var mins = fmod(time, 60*60) / 60
		var hours = fmod(fmod(time, 3600 * 60) / 3600, 24) 
		text = "%02d:%02d:%02d" % [hours, mins, sec]
	
func game_over():
	is_playing = false
	emit_signal("time_over", text)

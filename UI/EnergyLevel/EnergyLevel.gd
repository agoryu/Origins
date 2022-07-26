extends ProgressBar

func _ready():
	max_value = Game.max_energy
	
func _process(delta):
	value = $EnergyTimer.time_left

func _on_EnergyTimer_timeout():
	Game.game_over()

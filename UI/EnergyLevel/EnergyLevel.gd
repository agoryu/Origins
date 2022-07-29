extends ProgressBar

func _ready():
	Game.connect("add_energy", self, "add_energy")
	max_value = Game.max_energy
	value = max_value

func _on_EnergyTimer_timeout():
	value -= Game.energy_consume
	if value <= 0:
		Game.game_over()
		
func add_energy(energy: int):
	value += energy

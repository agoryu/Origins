extends TextureProgress

func _ready():
	Game.connect("add_energy", self, "add_energy")
	Game.connect("update_max_energy", self, "update_max_energy")

func _on_EnergyTimer_timeout():
	value -= FleetManager.energy_consume
	if value <= 0:
		Game.game_over()
		
func add_energy(energy: int):
	value += energy
	
func update_max_energy(max_energy: int):
	max_value += max_energy
	value += max_energy

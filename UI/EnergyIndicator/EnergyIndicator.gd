extends TextureProgress

export var percent_alert_threshold = 15

var is_alert = false

func _ready():
	Game.connect("add_energy", self, "add_energy")
	Game.connect("update_max_energy", self, "update_max_energy")

func _on_EnergyTimer_timeout():
	value -= FleetManager.energy_consume
	if value <= 0:
		Game.game_over()
	elif not is_alert and value <= (percent_alert_threshold * max_value) / 100:
		Game.start_alert()
		is_alert = true
	elif is_alert and value > (percent_alert_threshold * max_value) / 100:
		Game.stop_alert()
		is_alert = false
		
func add_energy(energy: int):
	value += energy
	
func update_max_energy(max_energy: int):
	max_value += max_energy
	value += max_energy

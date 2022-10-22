extends TextureProgress

export var percent_alert_threshold = 15
export var color_4 : Color = Color(1)
export var color_3 : Color = Color(1)
export var color_2 : Color = Color(1)
export var color_1 : Color = Color(1)

onready var _animation_player = $AnimationPlayer

var is_alert = false

func _ready():
	Game.connect("add_energy", self, "add_energy")
	FleetManager.connect("update_max_energy", self, "update_max_energy")

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
	switch_color()
		
func add_energy(energy: int):
	value += energy
	_animation_player.play("add_energy")
	
func update_max_energy(max_energy: int):
	max_value += max_energy
	value += max_energy
	_animation_player.play("add_energy")

func switch_color():
	if value <= max_value / 4:
		tint_progress = color_1
	elif value <= max_value / 2:
		tint_progress = color_2
	elif value <= (max_value / 4) * 3:
		tint_progress = color_3
	else:
		tint_progress = color_4

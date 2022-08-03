extends Timer

onready var energy_charge_constructor = preload("res://Bonus/EnergyCharge/EnergyCharge.tscn")

func spawn_element(spawn_location: PathFollow2D):
	var energy_charge = energy_charge_constructor.instance()
	spawn_location.offset = randi()
	energy_charge.global_position = spawn_location.global_position
	get_tree().root.add_child(energy_charge)

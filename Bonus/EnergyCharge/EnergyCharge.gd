extends "res://Bonus/Bonus.gd"

func _physics_process(delta: float) -> void:
	attract(delta)

func _on_EnergyCharge_body_entered(body):
	Game.add_energy(value)
	queue_free()

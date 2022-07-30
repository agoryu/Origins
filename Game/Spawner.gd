extends Node2D

onready var asteroid_constructor = preload("res://Characters/Enemies/Asteroid/Asteroid.tscn")
onready var energy_charge_constructor = preload("res://Objects/EnergyCharge/EnergyCharge.tscn")

onready var spawn_location = $SpawnerPath/PathFollow2D

func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_constructor.instance()
	spawn_location.offset = randi()
	asteroid.position = spawn_location.position
	
	var direction = Game.player.global_position.angle_to_point(spawn_location.global_position)
	var velocity = Vector2(rand_range(250.0, 350.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	add_child(asteroid)

func _on_EnergyChargeTimer_timeout():
	var energy_charge = energy_charge_constructor.instance()
	spawn_location.offset = randi()
	energy_charge.global_position = spawn_location.global_position
	get_tree().root.add_child(energy_charge)

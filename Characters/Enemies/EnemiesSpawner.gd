extends Node2D

onready var asteroid_constructor = preload("res://Characters/Enemies/Asteroid/Asteroid.tscn")
onready var spawn_location = $EnemiesPath/PathFollow2D

func _on_Timer_timeout():
	var asteroid = asteroid_constructor.instance()
	spawn_location.offset = randi()
	asteroid.position = spawn_location.position
	
	var direction = Game.player.position.angle_to_point(spawn_location.position)
	var velocity = Vector2(rand_range(250.0, 350.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	add_child(asteroid)

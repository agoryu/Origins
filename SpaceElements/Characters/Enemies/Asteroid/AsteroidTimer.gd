extends Timer

onready var asteroid_constructor = preload("res://SpaceElements/Characters/Enemies/Asteroid/Asteroid.tscn")

func spawn_element(spawn_location: PathFollow2D):
	var asteroid = asteroid_constructor.instance()
	spawn_location.offset = randi()
	asteroid.global_position = spawn_location.global_position
	
	var direction = Game.player.global_position.angle_to_point(spawn_location.global_position)
	asteroid.global_rotation = direction + PI/2
	asteroid.set_as_toplevel(true)
	
	add_child(asteroid)

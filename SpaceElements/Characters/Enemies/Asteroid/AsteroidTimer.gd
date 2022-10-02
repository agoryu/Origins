extends Timer

onready var asteroid_constructor = preload("res://SpaceElements/Characters/Enemies/Asteroid/Asteroid.tscn")

var time_spawn = 0
var speed_boost = 0

func spawn_element(spawn_location: PathFollow2D):
	var asteroid = asteroid_constructor.instance()
	spawn_location.offset = randi()
	asteroid.global_position = spawn_location.global_position
	
	var direction = FleetManager.player.global_position.angle_to_point(spawn_location.global_position)
	asteroid.global_rotation = direction + PI/2
	asteroid.set_as_toplevel(true)
	asteroid.speed += speed_boost
	
	asteroid.set_scale_damage(randi() % 3 + 1)
	
	add_child(asteroid)
	manage_level()
	
func manage_level():
	time_spawn += 1
	if time_spawn == 60 or time_spawn == 120:
		speed_boost += 100
	if time_spawn == 90:
		wait_time /= 2.0
	if time_spawn == 240:
		wait_time *= 2.0
		speed_boost -= 100

extends Ally

class_name Player

onready var laser_shoot_constructore = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")

onready var _audiostream_player = $AudioStreamPlayer2D
onready var _fleet_points = $FleetPoint
onready var _fleet = $Fleet

var _fleet_tab = []
var weapon_uses : int = 1

func _ready():
	Game.player = self
	_weapon = $Weapons
	is_player = true
	_life.display()

func _physics_process(delta: float) -> void:
	direction = get_gamepad_direction()
	
	move_in_direction(direction)
	
	if direction != Vector2.ZERO and not _audiostream_player.playing:
		_audiostream_player.play()
	elif direction == Vector2.ZERO and _audiostream_player.playing: 
		_audiostream_player.stop()

func _on_ShootTimer_timeout():
	var laser_shoot = laser_shoot_constructore.instance()
	laser_shoot.global_position = _weapon.get_child(weapon_uses).global_position
	laser_shoot.rotation = _sprite.rotation
	add_child(laser_shoot)
	laser_shoot.set_as_toplevel(true)
	laser_shoot.damage_caused += damage_added
	weapon_uses = (weapon_uses + 1) % 2

func add_ally(ally):
	var num_circle = _fleet.get_child_count() / _fleet_points.get_child_count()
	var pos_index = find_old_position()
	if pos_index != -1:
		_fleet_tab[pos_index] = ally
	else:
		pos_index = fmod(_fleet.get_child_count(), _fleet_points.get_child_count())
	
	ally.global_position = _fleet_points.get_child(pos_index).global_position * (num_circle + 1)
	add_child(ally)
	_fleet_tab.push_front(ally)
	ally.set_as_toplevel(true)
	Game.energy_consume += ally.energy_consume
	Game.add_max_energy(ally.energy_reserve)
	
func find_old_position() -> int:
	for i in len(_fleet_tab):
		if is_instance_valid(_fleet_tab[i]):
			return i
	return -1
	

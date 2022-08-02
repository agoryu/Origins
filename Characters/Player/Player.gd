extends "res://Characters/Allies/Ally.gd"

class_name Player

export var move_force_amplitude := 1000.0

onready var laser_shoot_constructore = preload("res://Weapons/LaserShoot/LaserShoot.tscn")
onready var sprite = $Sprite
onready var _weapons = $Weapons
onready var _audiostream_player = $AudioStreamPlayer2D

onready var _fleet_points = $FleetPoint
onready var _fleet = $Fleet
onready var _fleet_tab = []

var weapon_uses : int = 1

func _ready():
	Game.player = self
	sprite_texture = sprite.texture
	life = $Life
	shield = $Shield
	print(String(life.value) + " / " + String(life.max_value))

func _physics_process(delta: float) -> void:
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	applied_force = direction * move_force_amplitude
	sprite.rotation = linear_velocity.angle() + PI / 2
	_weapons.rotation = sprite.rotation
	
	if direction != Vector2.ZERO and not _audiostream_player.playing:
		_audiostream_player.play()
	elif direction == Vector2.ZERO and _audiostream_player.playing: 
		_audiostream_player.stop()

func _on_Player_body_entered(body):
	if body.collision_layer != 1:
		self._on_Character_body_entered(body)
		$AnimationPlayer.play("impact")
		if life.value <= 0:
			Game.game_over()

func _on_ShootTimer_timeout():
	var laser_shoot = laser_shoot_constructore.instance()
	laser_shoot.global_position = _weapons.get_child(weapon_uses).global_position
	laser_shoot.rotation = sprite.rotation
	add_child(laser_shoot)
	laser_shoot.set_as_toplevel(true)
	laser_shoot.damage += damage_added
	weapon_uses = (weapon_uses + 1) % 2

func add_ally(ally : Character):
	var num_circle = _fleet.get_child_count() / _fleet_points.get_child_count()
	var pos_index = find_old_position()
	if pos_index != -1:
		_fleet_tab[pos_index] = ally
	else:
		pos_index = fmod(_fleet.get_child_count(), _fleet_points.get_child_count())
	
	ally.position = _fleet_points.get_child(pos_index).position * (num_circle + 1)
	_fleet.add_child(ally)
	_fleet_tab.push_front(ally)
	Game.energy_consume += ally.energy_consume
	Game.add_max_energy(ally.energy_reserve)
	
func find_old_position() -> int:
	for i in len(_fleet_tab):
		if is_instance_valid(_fleet_tab[i]):
			return i
	return -1
	

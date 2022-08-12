extends Ally

class_name Player

onready var laser_shoot_constructore = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")

onready var _engine_audio = $EnginePlayer

var weapon_uses : int = 1

func _ready():
	Game.player = self
	Game.fleet_points = $PlayerNodes/FleetPoints
	Game.player_nodes = $PlayerNodes
	Game._fleet_tab.push_back(self)
	_weapon = $Weapons
	is_player = true

func _physics_process(delta: float) -> void:
	if is_player:
		player_move()
	else:
		move_ally(delta, Game.player)
	
	if direction != Vector2.ZERO and not _engine_audio.playing:
		_engine_audio.play()
	elif direction == Vector2.ZERO and _engine_audio.playing: 
		_engine_audio.stop()

func _on_ShootTimer_timeout():
	var laser_shoot = laser_shoot_constructore.instance()
	laser_shoot.global_position = _weapon.get_child(weapon_uses).global_position
	laser_shoot.rotation = _sprite.rotation
	add_child(laser_shoot)
	laser_shoot.set_as_toplevel(true)
	laser_shoot.damage_caused += damage_added
	weapon_uses = (weapon_uses + 1) % 2	

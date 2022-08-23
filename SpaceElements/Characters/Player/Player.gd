extends Ally

class_name Player

onready var laser_shoot_constructore = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")

onready var _engine_audio = $EnginePlayer

var weapon_uses : int = 1

func _ready():
	FleetManager.player = self
	FleetManager.fleet_points = $PlayerNodes/FleetPoints
	FleetManager.player_nodes = $PlayerNodes
	FleetManager.fleet_tab.push_back(self)
	FleetManager.energy_consume = energy_consume
	_weapon = $Weapons
	_fire = $Sprite/Fire
	is_player = true
	
#	FleetManager.add_ally(preload("res://SpaceElements/Characters/Allies/Enterprise/Enterprise.tscn").instance())
#	FleetManager.add_ally(preload("res://SpaceElements/Characters/Allies/XWing/XWing.tscn").instance())
#	FleetManager.add_ally(preload("res://SpaceElements/Characters/Allies/RadarShip/RadarShip.tscn").instance())

func _physics_process(delta: float) -> void:
	if is_player:
		player_move(delta)
	else:
		move_ally(delta, FleetManager.player)
	
	if direction != Vector2.ZERO and not _engine_audio.playing:
		_engine_audio.play()
	elif direction == Vector2.ZERO and _engine_audio.playing: 
		_engine_audio.stop()

func _on_ShootTimer_timeout():
	var laser_shoot = laser_shoot_constructore.instance()
	laser_shoot.global_position = _weapon.get_child(weapon_uses).global_position
	laser_shoot.rotation = _sprite.rotation
	laser_shoot.scale.x *= 1.5
	add_child(laser_shoot)
	laser_shoot.set_as_toplevel(true)
	laser_shoot.damage_caused += damage_added
	weapon_uses = (weapon_uses + 1) % 2

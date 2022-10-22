extends Node

signal update_allies
signal update_max_energy
signal max_lvl_ship
signal loose_ally
signal set_player

var player : Ally

# Fleet
var fleet_tab = []
var fleet_points : Node2D= null
var player_nodes : Node2D= null

# Energy management
var energy_consume : int = 1

var _navigation : Navigation2D = null

func _init():
	energy_consume = 1
	fleet_tab = []

func add_ally(ally):
	var pos = find_position()
	
	ally.global_position = pos.global_position
	_navigation.add_child(ally)
	fleet_tab.push_front(ally)
	ally.set_as_toplevel(true)
	FleetManager.energy_consume += ally.energy_consume
	add_max_energy(ally.energy_reserve)
	emit_signal("update_allies", FleetManager.calc_vector_radius())
	
func remove_ally(ally: Ally):
	emit_signal("loose_ally", ally)
	add_max_energy(-ally.energy_reserve)
	energy_consume -= ally.energy_consume
	fleet_tab.erase(ally)
	
func find_position() -> Area2D:
	for i in range(fleet_points.get_child_count()):
		var area = fleet_points.get_child(i) as Area2D
		if area.get_overlapping_bodies().size() <= 0:
			return area
	return fleet_points.get_child(0) as Area2D
	
func switch_ship(direction: int):
	if fleet_tab.size() > 0:
		var index = (fleet_tab.find(player) + direction) % fleet_tab.size()
		player.remove_child(player_nodes)
		player._animation_player.play("become_ally")
		player = fleet_tab[index]
		player.add_child(player_nodes)
		player._animation_player.play("become_player")
		emit_signal("set_player")
		
func add_max_energy(value: int):
	emit_signal("update_max_energy", value)
	
func max_lvl_ship():
	emit_signal("max_lvl_ship")
	
func calc_vector_radius() -> Vector2:
	var fleet_radius = 0.0
	for ally in fleet_tab:
		if not ally.is_in_group("player"):
			fleet_radius += (ally as Ally)._collision.shape.radius
	return Vector2.ONE * (1.0 + fleet_radius / 150.0)

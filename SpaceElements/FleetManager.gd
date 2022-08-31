extends Node

signal update_allies
signal update_max_energy
signal max_lvl_ship

var player : Ally

# Fleet
var fleet_tab = []
var fleet_points : Node2D= null
var player_nodes : Node2D= null

# Energy management
var energy_consume : int = 1

func _init():
	energy_consume = 1
	fleet_tab = []

func add_ally(ally):
	var pos = find_position()
	
	ally.global_position = pos.global_position
	add_child(ally)
	fleet_tab.push_front(ally)
	ally.set_as_toplevel(true)
	FleetManager.energy_consume += ally.energy_consume
	add_max_energy(ally.energy_reserve)
	emit_signal("update_allies", fleet_tab.size())
	
func remove_ally(ally: Ally):
	fleet_tab.erase(ally)
	emit_signal("update_allies", fleet_tab.size())
	
func find_position() -> Area2D:
	for i in range(fleet_points.get_child_count()):
		var area = fleet_points.get_child(i) as Area2D
		if area.get_overlapping_bodies().size() <= 0:
			return area
	return fleet_points.get_child(0) as Area2D
	
func switch_ship(direction: int):
	if fleet_tab.size() > 0:
		var index = (fleet_tab.find(player) + direction) % fleet_tab.size()
		player.is_player = false
		player.remove_child(player_nodes)
		player = fleet_tab[index]
		player.is_player = true
		player.add_child(player_nodes)
		
func add_max_energy(value: int):
	emit_signal("update_max_energy", value)
	
func max_lvl_ship():
	emit_signal("max_lvl_ship")

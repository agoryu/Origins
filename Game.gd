extends Node

signal update_xp
signal level_up
signal game_over
signal close_menu
signal make_pause
signal add_energy
signal update_max_energy
signal shake_screen

onready var tree = get_tree()

var player : Ally

# XP management
var xp : int = 0
var max_xp_value : int = 1
var xp_next_step : int = 1
var warning_level : int = 0

# Energy management
var energy_consume : int = 1

# Fleet
var _fleet_tab = []
var fleet_points : Node2D= null
var player_nodes : Node2D= null
	
func init():
	xp = 0
	max_xp_value = 1
	xp_next_step = 1
	warning_level = 0
	energy_consume = 1

func game_over():
	tree.paused = true
	emit_signal("game_over")

func add_xp(value: int):
	xp += value
	if xp >= max_xp_value:
		warning_level += 1
		xp -= max_xp_value
		tree.paused = true
		max_xp_value += 1
		emit_signal("level_up", xp, max_xp_value, warning_level)
	else:
		emit_signal("update_xp", xp)

func add_energy(value: int):
	emit_signal("add_energy", value)
		
func stop_pause():
	tree.paused = false
	emit_signal("close_menu")
	
func make_pause():
	tree.paused = true
	emit_signal("make_pause")

func restart():
	stop_pause()
	init()
	for object in tree.get_nodes_in_group("object"):
		object.queue_free()
	tree.reload_current_scene()
	
func exit():
	tree.quit()

func add_max_energy(value: int):
	emit_signal("update_max_energy", value)
	
func shake_screen():
	emit_signal("shake_screen")
	
func add_ally(ally):
	var pos_index = find_position()
	
	ally.global_position = fleet_points.get_child(pos_index).global_position
	add_child(ally)
	_fleet_tab.push_front(ally)
	ally.set_as_toplevel(true)
	Game.energy_consume += ally.energy_consume
	Game.add_max_energy(ally.energy_reserve)
	
func find_position() -> int:
	return 0
	
func switch_ship(direction: int):
	if _fleet_tab.size() > 0:
		var index = (_fleet_tab.find(player) + direction) % (_fleet_tab.size() - 1)
		player.set_is_player(false)
		player.remove_child(player_nodes)
		player = _fleet_tab[index]
		player.set_is_player(true)
		player.add_child(player_nodes)

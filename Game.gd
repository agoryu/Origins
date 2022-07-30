extends Node

signal update_xp
signal level_up
signal game_over
signal close_menu
signal make_pause
signal add_energy
signal update_max_energy

onready var tree = get_tree()
onready var ally1_constructor = preload("res://Characters/Allies/Enterprise.tscn")

var player : Player

# XP management
var xp : int = 0
var max_xp_value : int = 1
var xp_next_step : int = 1
var warning_level : int = 0

# Energy management
var energy_consume : int = 1
	
func init():
	xp = 0
	max_xp_value = 1
	xp_next_step = 1
	warning_level = 0

func game_over():
	tree.paused = true
	emit_signal("game_over")

func add_xp(value: int):
	xp += value
	if xp >= max_xp_value:
		warning_level += 1
		xp -= max_xp_value
		tree.paused = true
		max_xp_value += xp_next_step
		xp_next_step += 1
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
	for object in tree.get_nodes_in_group("object"):
		object.queue_free()
	tree.reload_current_scene()
	
func exit():
	tree.quit()

func add_max_energy(value: int):
	emit_signal("update_max_energy", value)

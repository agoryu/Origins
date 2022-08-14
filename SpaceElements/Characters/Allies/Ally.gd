extends Character

class_name Ally

onready var animation_player: AnimationPlayer = $AnimationPlayer

export var energy_consume = 1
export var energy_reserve = 1
export var limit_distance = 500
export var min_distance = 100
export var cooldown = 5

export var max_damage = 10
export var max_speed = 50
export var min_energy_consume = 4
export var max_life = 20

var direction = Vector2.ZERO
var is_player = false setget set_is_player
var is_selected = false

func add_damage(value: int):
	damage_added += value
	
func reduce_energy_consume(value: int):
	if energy_consume - value > 0:
		energy_consume -= value
	else:
		energy_consume = 1

func add_shield_value(value: int):
	_shield.shield_bar.max_value += value
	_shield.shield_bar.value += value
	_shield.visible = true
	
func impact_damage(value: int):
	.impact_damage(value)
	if _life.value <= 0:
		if not is_player:
			loose_ally()
		else:
			Game.game_over()
	Game.shake_screen()
	
func get_gamepad_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
func move_ally(delta: float, player):
	var current_direction = get_gamepad_direction()
	var player_distance = global_position.distance_to(player.global_position)
	
	if player_distance < min_distance:
		direction = global_position.direction_to(player.global_position).rotated(PI/2)
	elif player_distance > limit_distance:
		direction = global_position.direction_to(player.global_position)
	else:
		direction = current_direction
		
	move_in_direction(direction)
	
func loose_ally():
	Game.add_energy(-energy_consume)
	FleetManager.fleet_tab.erase(self)
	queue_free()
	
func player_move():
		direction = get_gamepad_direction()
		move_in_direction(direction)

func set_is_player(value: bool):
	is_player = value

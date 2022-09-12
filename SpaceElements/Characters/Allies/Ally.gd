extends Character

class_name Ally

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var shoot_timer: Timer = $ShootTimer

export var energy_consume = 1
export var energy_reserve = 1
export var min_cooldown : float = 0.2
export var max_damage = 10
export var max_speed = 50
export var min_energy_consume = 4
export var max_life = 20

var limit_distance = 150
var min_distance = 100
var _initial_speed = speed

const MAX_LVL = 5

var direction = Vector2.ZERO
var is_player = false setget set_is_player
var lvl : int = 0
var first_group : String = ""

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
	animation_player.play("blink")
	
func get_gamepad_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
func move_ally():
	var current_direction = get_gamepad_direction()
	var player = FleetManager.player
	var player_distance = global_position.distance_to(player.global_position)
	
	if get_slide_count() > 0 and wait_time_collision == 0:
		wait_time_collision = MAX_WAIT_TIME_COLLISION
		direction = current_direction
		for index_collision in range(get_slide_count()):
			var ally_collision = get_slide_collision(index_collision).collider as Ally
			direction -= ally_collision.direction
		direction /= 2.0
		
		
	if player_distance < min_distance:
			speed = min(FleetManager.player.speed, speed)
			direction = global_position.direction_to(player.global_position).rotated(PI/2)
	elif wait_time_collision == 0:
		if player_distance > limit_distance:
			speed = _initial_speed
			direction = global_position.direction_to(player.global_position)
		else:
			speed = min(FleetManager.player.speed, speed)
			direction = current_direction
	else:
		wait_time_collision -= 1
		
	move_in_direction(direction)
	
func loose_ally():
	FleetManager.remove_ally(self)
	queue_free()
	
func player_move():
		direction = get_gamepad_direction()
		move_in_direction(direction)

func set_is_player(value: bool):
	is_player = value

func lvl_up():
	if lvl + 1 <= MAX_LVL:
		lvl += 1
	if is_max_lvl():
		FleetManager.max_lvl_ship()
		
func is_max_lvl() -> bool:
	return lvl == MAX_LVL
		
func set_cooldown(value: float):
	shoot_timer.wait_time = value
	
func set_speed(value: int):
	speed += value
	_initial_speed += value

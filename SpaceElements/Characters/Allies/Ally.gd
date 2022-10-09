extends Character

class_name Ally

onready var _animation_player: AnimationPlayer = $CommonShipNode/AnimationPlayer
onready var _shoot_timer: Timer = $CommonShipNode/ShootTimer
onready var _navigation_agent : NavigationAgent2D = $CommonShipNode/NavigationAgent2D
onready var _find_target_timer : Timer = $CommonShipNode/FindTargetTimer

export var energy_consume = 1
export var energy_reserve = 1
export var min_cooldown : float = 0.2
export var max_damage = 10
export var max_speed = 50
export var min_energy_consume = 4
export var max_life = 20
export var limit_distance = 350
export var is_player = false setget set_is_player

var _initial_speed = speed

const MAX_LVL = 5

var direction = Vector2.ZERO
var lvl : int = 0
var first_group : String = ""
var is_invincible = true

func on_ready():
	_initial_speed = speed
	_find_target_timer.connect("timeout", self, "find_player")
	_navigation_agent.connect("velocity_computed", self, "move_velocity")

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
	if is_invincible:
		return
	.impact_damage(value)
	if _life.value <= 0:
		if not is_player:
			loose_ally()
		else:
			Game.game_over()
	Game.shake_screen()
	_animation_player.play("blink")
	
func get_gamepad_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
func move_ally():
	var current_direction = get_gamepad_direction()
	var player_distance = global_position.distance_to(FleetManager.player.global_position)
	
	if player_distance < limit_distance:
		speed = min(FleetManager.player.speed, speed)
		direction = current_direction
	else:
		speed = _initial_speed
		direction = global_position.direction_to(_navigation_agent.get_next_location())
		
	move_in_direction(direction)

func loose_ally():
	FleetManager.remove_ally(self)
	
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
	_shoot_timer.wait_time = value
	
func set_speed(value: int):
	speed += value
	_initial_speed += value

func get_ally_radius(ally: Ally) -> float:
	return ally._collision.shape.radius

func find_player():
	_navigation_agent.set_target_location(FleetManager.player.global_position)
	if is_invincible:
		is_invincible = false

func move_velocity(velocity: Vector2):
	_velocity = move_and_slide(velocity)
	_sprite.rotation = lerp(_sprite.rotation, velocity.angle(), 10 * get_physics_process_delta_time())

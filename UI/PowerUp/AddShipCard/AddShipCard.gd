extends Button

class_name AddShipCard

signal custom_selected

var red_rarity = Color(1.0, 0.2, 0.2)
var blue_rarity = Color(0.2, 0.2, 1.0)

onready var _icon = $VBoxContainer/HBoxContainer/ShipContainer/Icon
onready var _life = $VBoxContainer/HBoxContainer/StatsContainer/Stats/Life
onready var _weapon = $VBoxContainer/HBoxContainer/StatsContainer/Stats/Weapon
onready var _energy = $VBoxContainer/HBoxContainer/StatsContainer/Stats/Energy
onready var _energy_consume = $VBoxContainer/HBoxContainer/StatsContainer/Stats/EnergyConsume
onready var _speed = $VBoxContainer/HBoxContainer/StatsContainer/Stats/Speed
onready var _cooldown = $VBoxContainer/HBoxContainer/StatsContainer/Stats/Cooldown

var override_style = get_stylebox("normal").duplicate()
var override_style_focus = get_stylebox("focus").duplicate()

var powerup: SpecShipResources = null
var rarity = 0

func _ready():
	add_stylebox_override("normal", override_style)
	add_stylebox_override("focus", override_style_focus)

func set_ship(life: int, weapon: int, energy: int, energy_consume: int, speed: int, cooldown: float):
	_life.value = life
	_weapon.value = weapon
	_energy.value = energy
	_energy_consume.value = energy_consume
	_speed.value = speed
	_cooldown.value = cooldown

func _on_Card_button_up():
	var ship = powerup.ship_scene.instance() as Ally
	# Important that two value set before add ally
	ship.energy_reserve = _energy.value
	ship.damage_caused = _weapon.value
	FleetManager.add_ally(ship)
	ship._life.max_value = _life.value
	ship._life.value = _life.value
	ship.energy_consume = _energy_consume.value
	ship.speed = _speed.value
	ship.set_cooldown(_cooldown.value)
	ship.scale = Vector2.ONE + Vector2(float(rarity)/10.0, float(rarity)/10.0)
	emit_signal("custom_selected")
	
func set_rarity(color: Color, rarity_value: int):
	override_style.border_color = color
	override_style.bg_color = color
	override_style.bg_color.a = 0.5
	override_style_focus.bg_color = color
	override_style_focus.bg_color.a = 0.5
	rarity = rarity_value

func _on_Card_focus_entered():
	$AudioStreamPlayer.play()

func apply_rarity_color(rarity_component: int, component: Label):
	if rarity_component <= 1:
		component.add_color_override("font_color", blue_rarity)
	else:
		component.add_color_override("font_color", red_rarity)

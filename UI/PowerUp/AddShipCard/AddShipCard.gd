extends HBoxContainer

class_name AddShipCard

var icon = null
var _life = null
var _weapon = null
var _energy = null
var _energy_consume = null
var _speed = null
var _cooldown = null

func _init():
	icon = $Icon
	_life = $Stats/Life/Value
	_weapon = $Stats/Weapon/Value
	_energy = $Stats/Energy/Value
	_energy_consume = $Stats/EnergyConsume/Value
	_speed = $Stats/Speed/Value
	_cooldown = $Stats/Cooldown/Value

func set_ship(life: int, weapon: int, energy: int, energy_consume: int, speed: int, cooldown: int):
	_life.text = String(life)
	_weapon.text = String(weapon)
	_energy.text = String(energy)
	_energy_consume.text = String(energy_consume)
	_speed.text = String(speed)
	_cooldown.text = String(cooldown)

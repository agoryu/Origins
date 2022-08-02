extends Sprite

class_name Shield

onready var shield_bar = $ShieldBar
onready var anim_player = $AnimationPlayer

func set_values(shield: int, max_shield: int):
	shield_bar.max_value = max_shield
	shield_bar.value = shield
	if shield <= 0:
		self.visible = false

func show_shield_bar():
	anim_player.play("show_shield_bar")

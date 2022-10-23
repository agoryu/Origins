extends Node2D


func _ready():
	$AnimationPlayer.play("spawn")

func set_label(value: int):
	$Damage.text = "-" + String(value)

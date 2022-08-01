extends Button

onready var animation_player = $AnimationPlayer

func _ready():
	self.grab_focus()
	animation_player.play("anim_button")

func _on_StartButton_button_up():
	get_tree().change_scene("res://Origins.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	animation_player.play("anim_button")

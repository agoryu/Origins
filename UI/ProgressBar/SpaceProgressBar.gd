extends ProgressBar

class_name SpaceProgressBar

onready var animation_player = $AnimationPlayer
	
func display():
	animation_player.play("display")

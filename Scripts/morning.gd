extends TimeOfDay
class_name Morning

@onready var animationPlayer: AnimationPlayer = $Background/AnimationPlayer

func startTime():
	animationPlayer.play("textFadeIn")

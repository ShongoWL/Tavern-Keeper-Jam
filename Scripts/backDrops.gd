extends Node2D

@onready var textureRect: Sprite2D = $TextureRect
@onready var textureRect2: Sprite2D = $TextureRect2
@onready var textureRectOnScreen: VisibleOnScreenNotifier2D = $TextureRect/VisibleOnScreenNotifier2D
@onready var textureRectOnScreen2: VisibleOnScreenNotifier2D = $TextureRect2/VisibleOnScreenNotifier2D

@onready var timer: Timer = $Timer

#This returns the position and size of the viewport
@onready var viewportRect = get_viewport_rect()

#This for tweening ThumbsUp
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textureRect.set_position(Vector2(viewportRect.size.x/2,viewportRect.size.y/2))
	textureRect2.set_position(Vector2(viewportRect.size.x,0))

func nextPhase() -> void:
	print("button pressed")
	match textureRectOnScreen.is_on_screen():
		true:
			print("Im at 0")
			tween = create_tween()
			#This tween moves textureRect to a negative value equal to its size (-1920)
			tween.tween_property(textureRect, "position", Vector2(-viewportRect.size.x, textureRect.position.y),0.8)
			tween.parallel().tween_property(textureRect2, "position", Vector2(viewportRect.size.x/2, textureRect2.position.y),1)
			
			timer.start()
		false:
			print("hi")
			tween = create_tween()
			#This tween moves textureRect2 to a negative value equal to its size (-1920)
			tween.tween_property(textureRect2, "position", Vector2(-viewportRect.size.x, textureRect.position.y),0.8)
			tween.parallel().tween_property(textureRect, "position", Vector2(viewportRect.size.x/2, textureRect.position.y),1)
			
			timer.start()

func moveRectToRightmostPos():
	match textureRectOnScreen.is_on_screen():
		true:
			textureRect2.visible = false
			textureRect2.position.x = viewportRect.size.x * 1.5
			textureRect2.z_index = -1
			textureRect.z_index = 1
			textureRect2.visible = true
		false:
			textureRect.visible = false
			textureRect.position.x = viewportRect.size.x * 1.5
			textureRect.z_index = -1
			textureRect2.z_index = 1
			textureRect.visible = true

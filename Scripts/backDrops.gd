extends Node2D

@onready var textureRect: TextureRect = $TextureRect
@onready var textureRect2: TextureRect = $TextureRect2

@onready var timer: Timer = $Timer

#This returns the position and size of the viewport
@onready var viewportRect = get_viewport_rect()

#This for tweening ThumbsUp
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textureRect.size = viewportRect.size
	textureRect2.size = viewportRect.size
	
	textureRect.set_position(Vector2(0,0))
	textureRect2.set_position(Vector2(viewportRect.size.x,0))

func nextPhase() -> void:
	print("button pressed")
	match textureRect.position.x:
		0:
			print("Im at 0")
			tween = create_tween()
			#This tween moves textureRect to a negative value equal to its size (-1920)
			tween.tween_property(textureRect, "transform.position", Vector2(-viewportRect.size.x, textureRect.position.y),1)
			tween.parallel().tween_property(textureRect2, "transform.position", Vector2(0, textureRect2.position.y),1)
			
			moveRectToRightmostPos(textureRect2)
		viewportRect.size.x:
			print("hi")
			tween = create_tween()
			#This tween moves textureRect2 to a negative value equal to its size (-1920)
			tween.tween_property(textureRect2, "position", Vector2(-viewportRect.size.x, textureRect.position.y),1)
			tween.parallel().tween_property(textureRect, "position", Vector2(0, textureRect.position.y),1)
			
			moveRectToRightmostPos(textureRect)

func moveRectToRightmostPos(rectangle: TextureRect):
	timer.start()
	await timer.timeout
	
	rectangle.visible = false
	rectangle.position = Vector2(viewportRect.size,0)
	rectangle.visible = true
	print("it works if this happens a second after the original button press")

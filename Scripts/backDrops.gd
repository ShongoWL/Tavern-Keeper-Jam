extends Node2D

@onready var scene1Parent: Node2D = $Scene1Parent
@onready var scene2Parent: Node2D = $Scene2Parent
@onready var scene1OnScreen: VisibleOnScreenNotifier2D = $Scene1Parent/VisibleOnScreenNotifier2D
@onready var scene2OnScreen: VisibleOnScreenNotifier2D = $Scene2Parent/VisibleOnScreenNotifier2D

@onready var time1: TimeOfDay = $Scene1Parent/Morning
@onready var time2: TimeOfDay = $Scene2Parent/Shop

@onready var timer: Timer = $Timer

#This returns the position and size of the viewport
@onready var viewportRect = get_viewport_rect()

#This for tweening ThumbsUp
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene1Parent.set_position(Vector2(0,0))
	scene2Parent.set_position(Vector2(viewportRect.size.x,0))

func nextPhase() -> void:
	print("button pressed")
	
	moveScenes()
	time1.startTime()
	#SignalBus.newTimeOfDay.emit(thenewtime)  Add this in later


func moveScenes() -> void:
	match scene1OnScreen.is_on_screen():
		true:
			print("Im at 0")
			tween = create_tween()
			#This tween moves textureRect to a negative value equal to its size (-1920)
			tween.tween_property(scene2Parent, "position", Vector2(0, scene2Parent.position.y),1)
			tween.parallel().tween_property(scene1Parent, "position", Vector2(-viewportRect.size.x, scene1Parent.position.y),1)
			
		false:
			print("hi")
			tween = create_tween()
			#This tween moves textureRect2 to a negative value equal to its size (-1920)
			tween.tween_property(scene1Parent, "position", Vector2(0, scene1Parent.position.y),1)
			tween.parallel().tween_property(scene2Parent, "position", Vector2(-viewportRect.size.x, scene2Parent.position.y),1)
	
	timer.start()

func moveRectToRightmostPos():
	match scene1OnScreen.is_on_screen():
		true:
			scene2Parent.visible = false
			scene2Parent.position.x = viewportRect.size.x
			scene2Parent.z_index = -1
			scene1Parent.z_index = 1
			scene2Parent.visible = true
		false:
			scene1Parent.visible = false
			scene1Parent.position.x = viewportRect.size.x
			scene1Parent.z_index = -1
			scene2Parent.z_index = 1
			scene1Parent.visible = true

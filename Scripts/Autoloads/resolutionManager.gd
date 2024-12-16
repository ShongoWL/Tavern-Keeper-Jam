extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(1280, 720)) ##This is here so I can keep the editor window at 640x360
	## but I can open the game at a resolution closer to what players will see

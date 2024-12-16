extends Control
class_name ItemPanel

@onready var itemSprite: TextureRect = $ItemSprite
@onready var label: Label = $ItemSprite/Label

var itemHeld: Item
var dragItem: bool = false
var itemSpriteBasePos: Vector2

func _ready() -> void:
	itemSpriteBasePos = itemSprite.position
	if itemHeld:
		itemSprite.texture = itemHeld.sprite
		itemSprite.visible = true
		itemHeld.holder = self

func _process(delta: float) -> void:
	if dragItem == true:
		itemSprite.position = get_local_mouse_position() - itemSprite.custom_minimum_size/2

#add a little money tag for price

func _get_drag_data(at_position: Vector2) -> Item: ##A, I believe this code is right but for some
	##reason in main the shopScene and the userInterface fight each other and depending on the way they're
	##set up one or the other won't receive ANY inputs?????
	
	##A, I figured it out, weirdness with control nodes. Long story short, a node that was supposed
	## to just be "node" was actually "control" and it was blocking inputs
	var dragPre = TextureRect.new()
	dragPre.texture = itemHeld.sprite
	set_drag_preview(dragPre)
	return itemHeld

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Item and itemHeld == null:	return true
	else: return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.holder.removeItem()
	
	itemHeld = data
	updateItem()

func updateItem():
	if itemHeld:
		itemSprite.texture = itemHeld.sprite
		label.text = str(itemHeld.price)
		itemSprite.visible = true
		itemHeld.holder = self
		print(itemHeld.itemName + " is held by " + name)
	else:	itemSprite.visible = false

func removeItem() -> void:
	itemHeld = null
	updateItem()

## A, commented this out for now while I test control's native _drop methods
"""func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			accept_event()
			dragItem = true
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_action_released("mouse_left_click"):
			accept_event()
			dragItem = false
			var tween = create_tween()
			tween.tween_property(itemSprite,"position",itemSpriteBasePos,0.3)
			#itemSprite.position = itemSpriteBasePos
			#add something about, if dragged over to inventory buy and put it in that slot"""
			
func mouse_hovering():
	accept_event()
	var timer = Timer.new()
	timer.wait_time = 2
	timer.timeout.connect(showTooltip)
	timer.start()

func showTooltip():
	pass

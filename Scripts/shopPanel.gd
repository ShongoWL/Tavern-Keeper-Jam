extends Control
class_name ShopPanel

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

func _process(delta: float) -> void:
	if dragItem == true:
		itemSprite.position = get_local_mouse_position() - itemSprite.custom_minimum_size/2

#add a little money tag for price

func updateItem():
	if itemHeld:
		itemSprite.texture = itemHeld.sprite
		label.text = str(itemHeld.price)
		itemSprite.visible = true
		print(itemHeld.itemName)

func _gui_input(event: InputEvent) -> void:
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
			#add something about, if dragged over to inventory buy and put it in that slot

func mouse_hovering():
	accept_event()
	var timer = Timer.new()
	timer.wait_time = 2
	timer.timeout.connect(showTooltip)
	timer.start()

func showTooltip():
	pass

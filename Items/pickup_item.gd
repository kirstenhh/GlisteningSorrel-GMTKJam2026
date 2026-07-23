extends Area2D

@export var item_name = "blank"
signal picked_up(my_name: String, carried: bool)
var carried = false
# Item that can be picked up and carried back to base
# Interaction: item is attached to player 
var interact: Callable = func():
	print("Interact called on "+item_name)
	picked_up.emit(item_name, carried)
	carried = not carried

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_name = get_parent().name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

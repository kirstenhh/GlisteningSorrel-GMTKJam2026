extends Area2D

@export var item_name = "blank"

# "Station" in the bunker
# Interaction: check if player has your item
# if player has your item, remove item from player, and output values
# and set your state to revealed
var interact: Callable = func():
	print("Interact called on "+item_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

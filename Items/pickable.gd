extends Area2D

@export var item_name = "blank"
@export var examinable = true
@export var pickable = true
@export var interactable = false

signal picked_up(my_name: String, carried: bool)
var carried = false
# Item that can be picked up and carried back to base
# Interaction: item is attached to player 

var examine: Callable = func():
	print("I am being examined: "+item_name)
	
var pickup: Callable = func():
	picked_up.emit(item_name, carried)
	carried = not carried
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_name = get_parent().name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

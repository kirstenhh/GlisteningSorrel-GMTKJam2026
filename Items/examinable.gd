extends Area2D

@export var item_name = "blank"
@export var examinable = true
@export var pickable = false
# Interaction item: just pops up text
# Used for revealing codes and things
var examine: Callable = func():
	print("Examine called on "+item_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

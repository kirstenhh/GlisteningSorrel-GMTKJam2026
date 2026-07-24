extends Area2D

@export var item_name = "blank"

#TODO something marginally more elegant
@export var examinable = true
@export var pickable = false
@export var interactable = false
# Examine item: just pops up text
# Used for revealing codes and clues, etc.
var examine: Callable = func():
	print("examine called on "+item_name)
	TextManager.push_item_texts(item_name)
	#Codes: override this so you can push an additional item, 
	# or TODO push_item_texts with a format% string 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_name = get_parent().name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

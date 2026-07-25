extends Area2D

@onready var interactable: Area2D = $Interactable
@export var to_bunker: bool
signal reveal_hidden_room
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(interactable)
	interactable.interact = reveal_room


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func reveal_room(any):
	reveal_hidden_room.emit()
	

# TODO: ## Player enters the area at the top of the stairs,
	## and "walks out" of the bunker
#func _on_area_entered(area: Area2D) -> void:

	#print("move to the outside")
	#print(to_bunker)
	#move_through_door.emit(to_bunker)

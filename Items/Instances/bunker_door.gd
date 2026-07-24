extends Area2D

@onready var interactable: Area2D = $Interactable
signal move_through_door(to_bunker: bool)
@export var to_bunker: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = move_to_bunker


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to_bunker():
	move_through_door.emit(to_bunker)

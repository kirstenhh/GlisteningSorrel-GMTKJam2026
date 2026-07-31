extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
var interact_item = "Key"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#examinable.examine = update_text
	pass #interactable.interact = use_item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

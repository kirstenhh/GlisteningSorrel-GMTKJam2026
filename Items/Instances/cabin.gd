extends StaticBody2D
@onready var examinable: Area2D = $Examinable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#examinable.examine = update_text
	pass #interactable.interact = use_item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

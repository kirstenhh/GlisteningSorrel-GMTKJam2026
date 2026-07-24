extends StaticBody2D

@onready var interactable: Area2D = $Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = code_entry_dialog


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func code_entry_dialog():
	print("Entering a code!")
	#Temp: Just enters the code for you
	var clock = get_node("/root/Main/UI/Clock").enterCode("4815")

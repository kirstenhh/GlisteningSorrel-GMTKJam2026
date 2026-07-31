extends StaticBody2D

@onready var interactable: Area2D = $Interactable
signal enter_code_requested
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = code_entry_dialog


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#TODO dialog for user
func code_entry_dialog(any=false):
	enter_code_requested.emit()
	
	#Temp: Just enters the code for you
	#var clock = get_node("/root/Main/UI/Clock")
	#var code = clock.MachineCode
	#clock.enterCode(code)
func green_flash():
	$Flash.visible = true
	$Flash.modulate = Color(1,1,1,0)
	var tween = get_tree().create_tween()
	tween.tween_property($Flash, "modulate", Color(1,1,1,1), 0.2)
	tween.tween_property($Flash, "modulate", Color(1,1,1,0), 0.2)
	tween.tween_property($Flash, "modulate", Color(1,1,1,1), 0.2)
	tween.tween_property($Flash, "modulate", Color(1,1,1,0), 0.9)
	tween.tween_callback($Flash.hide)	

	

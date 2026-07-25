extends Panel
@onready var spin_box: SpinBox = $SpinBox
var line_edit:LineEdit 
signal text_submitted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit = $SpinBox.get_line_edit()
	line_edit.context_menu_enabled = false
	line_edit.connect("text_submitted", _on_text_submitted)     

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_panel():
	show()
	line_edit.edit()

func _on_text_submitted(new_text:String):   
	print("pressed enter with this text: ", new_text)
	text_submitted.emit(new_text)

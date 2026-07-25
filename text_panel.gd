extends Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func show_message(text) -> void:
	show()
	visible = true
	var code = get_node("../Clock").MachineCode
	var safe_code = get_node("../Clock").SafeCode
	for i in range(len(code)):
		text = text.replace("$code"+str(i), code[i])
	for i in range(len(safe_code)):
		text = text.replace("$safe"+str(i), safe_code[i])
		

	$BottomText.text = text
	
func hide_panel():
	$BottomText.text = ""
	hide()

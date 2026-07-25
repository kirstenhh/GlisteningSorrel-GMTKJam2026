extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
@export var unlocked = false

@onready var code_entry: Container = $SafeCodeEntryBox/HBoxContainer
var line_edits = []


signal safe_text_submitted
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	examinable.examine = examine
	interactable.interact = safe_enter_code
	for i in range(1,4):
		line_edits.push_back(code_entry.get_node("SpinBox"+str(i)).get_line_edit())
	for edit in line_edits:
		edit.context_menu_enabled = false
		edit.connect("text_submitted", _on_safe_text_submitted)     

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func update_text(): 
	#TextManager.text_queue.push_back("There's a strange book here! It's missing a page...")
	#TextManager.text_queue.push_back("The previous page has some text, though.")
	#TextManager.text_queue.push_back("It says, 'Turn the safe dial clockwise, counterclockwise")
	#TextManager.text_queue.push_back("and clockwise to the following values: ...")
	#TextManager.text_queue.push_back("Then the torn page. The rest of the book is empty.")
func examine():
	if unlocked:
		TextManager.push_item_texts(name+"-unlocked")
	else:
		TextManager.push_item_texts(name)

func safe_enter_code(any: String):
	$SafeCodeEntryBox.show()
	
	#TextManager.text_queue.push_back("Wow, I can combine these!")
	return false

func code_success():
	print("Safe says: that worked!")
	$SafeCodeEntryBox.hide()
	TextManager.push_item_texts(name+"-unlocked")
	$Sprite2D.visible = false
	$Sprite2D_after.visible = true
	unlocked = true
	
func _on_safe_text_submitted(new_text:String):   
	safe_text_submitted.emit(line_edits[0].text,line_edits[1].text,line_edits[2].text)

extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
@export var unlocked = false
var interact_item = "Key"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	examinable.examine = examine
	interactable.interact = use_item

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

func use_item(interactor_name: String):
	if !interactor_name:
		return
	if interactor_name == interact_item:
		TextManager.push_item_texts(name+"-unlocked")
		$Sprite2D.visible = false
		$Sprite2D_after.visible = true
		unlocked = true
		#TextManager.text_queue.push_back("Wow, I can combine these!")
		return true
		

extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
@export var unlocked_first = false
@export var unlocked_second = false
var interact_item_1 = "Vinyl"
var interact_item_2 = "VinylPlayer"

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
	
	if unlocked_first and not unlocked_second:
		TextManager.push_item_texts(name+"-first")
	elif not unlocked_first and unlocked_second:
		TextManager.push_item_texts(name+"-second")
		$Sprite2D.visible = false
		$Sprite2D_after.visible = true
	elif unlocked_first and unlocked_second:
		TextManager.push_item_texts(name+"-unlocked")
		$Sprite2D.visible = false
		$Sprite2D_after.visible = true
	else:	 #Nothing unlocked
		TextManager.push_item_texts(name)
		

func use_item(interactor_name: String):
	if !interactor_name:
		return
	if not unlocked_first and interactor_name == interact_item_1:
		unlocked_first = true
		examine()
		return true
	if not unlocked_second and interactor_name == interact_item_2:
		unlocked_second = true
		examine()
		return true
	print("Other interaction: nothing")
	return false
		
	
	
		

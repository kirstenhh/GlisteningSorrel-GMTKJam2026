extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
var interact_item = "Post-it"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#examinable.examine = update_text
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

func use_item(item: Node2D):
	if item.has_node("Pickable"):
		print("Item is "+item.get_node("Pickable").item_name)
	if item.get_node("Pickable").item_name == interact_item:
		print("This is my interactor! Clue to follow.")

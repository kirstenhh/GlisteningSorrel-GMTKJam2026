extends StaticBody2D
@onready var textitem: Area2D = $TextItem
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textitem.interact = update_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_text(): 
	
	TextManager.text_queue.push_back("There's a strange book here! It's missing a page...")
	TextManager.text_queue.push_back("The previous page has some text, though.")
	TextManager.text_queue.push_back("It says, 'Turn the safe dial clockwise, counterclockwise")
	TextManager.text_queue.push_back("and clockwise to the following values: ...")
	TextManager.text_queue.push_back("Then the torn page. The rest of the book is empty.")

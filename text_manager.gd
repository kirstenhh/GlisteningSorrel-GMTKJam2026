extends Node

var text_queue = []
# Called when the node enters the scene tree for the first time.

var text_sets = {
	"Bookshelf": ["There's a strange book here! It's missing a page...","The previous page has some text, though.", "It says, 'Turn the safe dial clockwise, counterclockwise", "and clockwise to the following values: ...","Then the torn page. The rest of the book is empty."],
	"Calendar": ["A wall calendar for May 2004.", "Oh! There's a message here: ","The starting code is $code0 $code1 $code2 $code3!"],
	"Speaker": [],
	"Projector": []
}
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func push_item_texts(item_name: String, code= ""):
	var current_texts = text_sets[item_name]
	for text in current_texts:
		text_queue.push_back(text)

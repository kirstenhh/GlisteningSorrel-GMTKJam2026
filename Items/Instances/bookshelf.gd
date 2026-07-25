extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
var interact_item = "Photo"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#examinable.examine = update_text
	interactable.interact = use_item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func use_item(item_name: String):
	if !item_name:
		return false
	if item_name == interact_item:
		#TextManager.push_item_texts("Bookshelf-interact")
		TextManager.text_queue.push_back("Wow, I can combine these!")
		return true

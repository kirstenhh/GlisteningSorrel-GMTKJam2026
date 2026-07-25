extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
@export var unlocked = false
var interact_item = "Film"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	examinable.examine = examine
	interactable.interact = use_item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		#TODO: actually play an animation instead of text
		unlocked = true
		#TextManager.text_queue.push_back("Wow, I can combine these!")
		return true
		

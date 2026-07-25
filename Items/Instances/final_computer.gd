extends StaticBody2D
@onready var examinable: Area2D = $Examinable
@onready var interactable: Area2D = $Interactable
@export var unlocked = false
var interact_item = "Key"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	examinable.examine = win_game()
	interactable.interact = win_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func win_game(any=""):
	print("Game is WON")
	TextManager.push_item_texts("GameWon")

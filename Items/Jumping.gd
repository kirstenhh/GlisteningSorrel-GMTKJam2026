extends Area2D


@export var item_name = "blank"
signal jumping
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_name = get_parent().name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Interaction item: general category
# can take an argument -> can be used to interact with objects
# Or can be used for single interactions, e.g. bunker door and countdown computer
var interact: Callable = func(argument = false):
	print("interact called on "+item_name)
	if argument:
		print ("	using "+item_name)
	jumping.emit()

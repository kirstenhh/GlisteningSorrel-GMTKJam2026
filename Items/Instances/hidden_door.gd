extends Area2D
@onready var interactable: Area2D = $Interactable
signal reveal_hidden_room
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = open_door
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.disabled = true
	$Interactable/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func open_door(any):
	$AnimatedSprite2D.animation = "open"
	
	$StaticBody2D/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play()

func turn_on():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.modulate = Color(1,1,1,0)
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1,1,1,1), 2.0)
	$CollisionShape2D.disabled = false
	$Interactable/CollisionShape2D.disabled = false
	$StaticBody2D/CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D):
	if body.get_class() == "CharacterBody2D":
		reveal_hidden_room.emit()

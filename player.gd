extends CharacterBody2D


@export var speed = 300
@export var controlling = true

var action = false #TODO true till interact animation is done
var available_interactions = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if available_interactions and controlling:
			await available_interactions[0].interact.call()
		
func _process(_delta:float) -> void:
	if available_interactions:
		available_interactions.sort_custom(nearest)

func _physics_process(_delta: float) -> void:
	
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	if not controlling:
		return
	elif direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
		if direction.x != 0:
			rotation_degrees = 90 * direction.x
		elif direction.y > 0:
			rotation_degrees = 180
		elif direction.y < 0: 
			rotation_degrees = 0
	elif not action:
		$AnimatedSprite2D.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
	


func _on_interact_area_area_entered(area: Area2D) -> void:
	available_interactions.push_back(area)


func _on_interact_area_area_exited(area: Area2D) -> void:
	available_interactions.erase(area)


func nearest(a1, a2):
	var a1_dist = global_position.distance_to(a1)
	var a2_dist = global_position.distance_to(a2)
	return a1_dist < a2_dist
		

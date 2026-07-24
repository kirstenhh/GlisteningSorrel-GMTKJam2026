extends CharacterBody2D


@export var speed = 300
@export var controlling = true
@export var carrying = false

var action = false #TODO true till interact animation is done
var available_examinations = []
var available_pickups = []

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and controlling:
		if carrying: #Carrying an item -> it gets priority
			#NB: The picked up item will signal the main scene, which checks for combinables
			await $CarryItem.get_child(0).get_node("Pickable").pickup.call()
		elif available_pickups: # pick up nearest item
			await available_pickups[0].pickup.call()
	elif controlling and event.is_action_pressed("examine") and available_examinations:
		await available_examinations[0].examine.call()
		
func _process(_delta:float) -> void:
	if available_examinations:
		available_examinations.sort_custom(nearest)

func _physics_process(_delta: float) -> void:
	
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if not controlling:
		return
	elif direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		if carrying: 
			$AnimatedSprite2D.animation = "carry"
		else:
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
	if area.examinable:
		available_examinations.push_back(area)
	if area.pickable:
		available_pickups.push_back(area)
	# TODO combinable


func _on_interact_area_area_exited(area: Area2D) -> void:
	if area.examinable:
		available_examinations.erase(area)
	if area.pickable:
		available_pickups.erase(area)


func nearest(a1, a2):
	var a1_dist = global_position.distance_to(a1.global_position)
	var a2_dist = global_position.distance_to(a2.global_position)
	return a1_dist < a2_dist
		

extends CharacterBody2D


@export var speed = 300
@export var controlling = true

#todo: remove this, just check $CarryItem for children
@export var carrying = false

var available_examinations = []
var available_pickups = []
var available_interactions = []
var prev_direction = Vector2(-1,0) # For controlling the Idle animation

func _input(event: InputEvent) -> void:
	if controlling and event.is_action_pressed("interact"):
		# Check for interactions FIRST, because they're often more important
		if available_interactions:
			if carrying:
				var returned = await available_interactions[0].interact.call($CarryItem.get_child(0).name)
				print(returned)
				if returned: 
					print("Successfully used items together!")
					$CarryItem.remove_child($CarryItem.get_child(0))
					carrying = false
			else:
				await available_interactions[0].interact.call("")
		elif carrying: #Carrying an item -> it gets priority
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
	elif direction: #Moving
		# TODO normalize speed (diagonals are too fast right now)
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		if carrying: 
			handle_animation("carry", direction)
			# Move holding position according to L/R orientation
			if direction.x <0:
				$CarryItem.position = Vector2(-10,0)
			else:
				$CarryItem.position = Vector2(10,0)
		else:
			handle_animation("walk", direction)
		prev_direction = direction
	else:
		handle_animation("idle", prev_direction)
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	$AnimatedSprite2D.play()
	move_and_slide()
	

func handle_animation(action: String, direction: Vector2):
	$AnimatedSprite2D.flip_h = false
	if direction.x < 0: #left
		$AnimatedSprite2D.animation = action+"-side"
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0: #right
		$AnimatedSprite2D.animation = action+"-side"
	elif direction.y < 0: #up
		$AnimatedSprite2D.animation = action+"-up"
	else: #down : elif direction == Vector2(0,1): #down
		$AnimatedSprite2D.animation = action+"-down"

func _on_interact_area_area_entered(area: Area2D) -> void:
	if area.name == "Examinable":
		available_examinations.push_back(area)
	if area.name == "Pickable":
		available_examinations.push_back(area)
		available_pickups.push_back(area)
	if area.name == "Interactable":
		available_interactions.push_back(area)
	if area.name == "BunkerStairs":
		print("entering Door")


func _on_interact_area_area_exited(area: Area2D) -> void:
	if  area.name == "Examinable":
		available_examinations.erase(area)
	if area.name == "Pickable":
		available_examinations.erase(area)
		available_pickups.erase(area)
	if area.name == "Interactable":
		available_interactions.erase(area)
	if area.name == "BunkerStairs":
		print("leaving Door")


func nearest(a1, a2):
	var a1_dist = global_position.distance_to(a1.global_position)
	var a2_dist = global_position.distance_to(a2.global_position)
	return a1_dist < a2_dist
		

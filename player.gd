extends CharacterBody2D


@export var speed = 300




func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if Input.is_action_just_pressed("interact"):
		$AnimatedSprite2D.animation = "interact"
		$AnimatedSprite2D.play()
		print("Interacting")
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
	else:
		$AnimatedSprite2D.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
	

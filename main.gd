extends Node
# THIS IS THE MAIN GAME PROGRAM
# at least until we decide if we go full OOP or if we do other things

var text_on = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("moving text queue along")
		if TextManager.text_queue:
			$UI/TextPanel.show_message(TextManager.text_queue.pop_front())
		else:
			text_on = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not text_on and TextManager.text_queue: # start a text interaction
		print("Show text")
		text_on=true
		$Player.controlling = false
		$UI/TextPanel.visible=true
		$UI/TextPanel.show_message(TextManager.text_queue.pop_front())
	elif text_on and not TextManager.text_queue: #text is still on, but queue is empty
		$UI/TextPanel.visible=false
		$Player.controlling = true

		

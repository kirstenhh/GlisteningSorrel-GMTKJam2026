extends Node
# THIS IS THE MAIN GAME PROGRAM
# at least until we decide if we go full OOP or if we do other things
enum Game_State{
	NEW_GAME,
	PLAYING, #Player has control and is moving about
	READING, #Text box is on screen
	TYPING, #Interact with UI elements (entering code)
	GAME_OVER
}
var current_state = Game_State.NEW_GAME
var next_state = Game_State.PLAYING
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") or event.is_action_pressed("examine"):
		match current_state:
			Game_State.PLAYING:
				$Player.controlling = true
				$UI/TextPanel.hide_panel()
				if TextManager.text_queue:
					current_state=Game_State.READING
					var text = TextManager.text_queue.pop_front()
					$UI/TextPanel.show_message(text)
			Game_State.READING:
				if TextManager.text_queue:
					var text = TextManager.text_queue.pop_front()
					$UI/TextPanel.show_message(text)
				else:
					current_state = Game_State.PLAYING
					$UI/TextPanel.hide_panel()
			Game_State.TYPING:
				print("Consider this an Enter")
				$UI/CodeEntryBox.hide()
				next_state = Game_State.PLAYING
				# Submit code for checking, popup Yes or No
			Game_State.GAME_OVER:
				print("GAME OVER. ")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Start and end the text tree
	if not current_state==Game_State.READING and TextManager.text_queue: # start a text interaction
		current_state=Game_State.READING
	match current_state:
		Game_State.NEW_GAME:
			current_state = Game_State.PLAYING
			#$UI/TextPanel.hide_panel()
		Game_State.PLAYING:
			$Player.controlling = true
			#$UI/TextPanel.hide()
			if TextManager.text_queue:
				current_state=Game_State.READING
				var text = TextManager.text_queue.pop_front()
				print("message: "+text)
				$UI/TextPanel.show_message(text)
		Game_State.READING:
			$Player.controlling = false
		Game_State.TYPING:
			$Player.controlling = false
			$UI/CodeEntryBox.show()
		Game_State.GAME_OVER:
			print("GAME OVER. ")
	if next_state: 
		current_state = next_state
		next_state = null

	#udpate timer on corner of screen
	$UI/TimerCorner/TimeLeft.set_text(str(int($UI/Clock.time_left)))



func _on_pickable_picked_up(my_name: String, carried: bool) -> void:
	print("Picking up " + my_name)
	if carried:
		var carried_item = $Player/CarryItem.get_child(0)
		# Check interactions: if includes item's station, interact. 
		carried_item.reparent($PickupItems)
		carried_item.position.x+=10
		carried_item.position.y+=10
		
		#$Player/CarryItem.remove_child(carried_item)
		$Player.carrying = false
		
		# TODO
		# Check if there is an interactable in area
		# check if it's MY interactable
		# If yes, trigger interactable.

	else:	
		var pickup_item = get_node("PickupItems/"+my_name)
		pickup_item.reparent($Player/CarryItem)
		pickup_item.position = Vector2.ZERO
		$Player.carrying = true


func _on_move_through_door(to_bunker: bool) -> void:
	if to_bunker: 
		$Player.global_position = $BunkerStairs.global_position # move character to bunker
		$BunkerCamera.make_current()
	else:
		# move character to just outside door
		$Player.position = $BunkerDoor.global_position
		$Player/Camera2D.make_current()


func _on_enter_code_requested() -> void:
	print("Entering Code: ")
	next_state = Game_State.TYPING
	
	$UI/CodeEntryBox.visible = true


func _on_clock_game_over() -> void:
	#Handle resetting the whole game
	current_state=Game_State.NEW_GAME
	
	get_tree().change_scene_to_file("res://examples/scenes/menus/main_menu/main_menu.tscn") #to return to main menu
	

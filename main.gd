extends Node
# THIS IS THE MAIN GAME PROGRAM
# at least until we decide if we go full OOP or if we do other things
enum Game_State{
	NEW_GAME,
	PLAYING, #Player has control and is moving about
	READING, #Text box is on screen
	TYPING, #Interact with UI elements (entering code)
	GAME_OVER,
	GAME_WON
}
var current_state = Game_State.NEW_GAME
var next_state = Game_State.READING #-> updates current_state at the next process tick
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextManager.reset()
	#Startup "cinematic"
	$BunkerCamera.make_current() #start inside of bunker, so use this camera
	$Player.controlling = false #blocks player from moving during intro
	$UI/Clock/WhiteLight/Flash.play("UnFlash")
	$UI/Clock/WhiteLight.visible=true
	$UI/TextPanel.show_message("What the hell was that Flash? Wait where am I?")
	await $UI/Clock/WhiteLight/Flash.animation_finished
	$UI/Clock/WhiteLight.visible=false
	$UI/TextPanel.show_message("(press E to examine, press R to interact or pick up items,")
	TextManager.push_item_texts("a (?) bubble indicates that you can examine something, ")
	TextManager.push_item_texts("a (!) bubble indicates that you can also interact with or grab it)")
	TextManager.push_item_texts("Hold on... I kind of recognize this place. It's a laboratory... but what for?")
	TextManager.push_item_texts("Hey that large computer in the corner is beeping...")
	
func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") or event.is_action_pressed("examine"):
		match current_state:
			Game_State.PLAYING:
				$Player.controlling = true
				$UI/TextPanel.hide_panel()
				$UI/CodeEntryBox.hide()
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
			Game_State.GAME_WON:
				print("win")
				if TextManager.text_queue:
					var text = TextManager.text_queue.pop_front()
					$UI/TextPanel.show_message(text)
				else:
					$UI/TextPanel.show_message("RUN.")
					print("Running...")
					$Ending/Cinematic.play()

			Game_State.TYPING:
				pass # In case the user tries to type text
			Game_State.GAME_OVER:
				print("GAME OVER. ")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Start and end the text tree
	if current_state==Game_State.PLAYING and TextManager.text_queue: # start a text interaction
		current_state=Game_State.READING
	match current_state:
		Game_State.NEW_GAME:
			#current_state = Game_State.PLAYING
			#Will shift to READING state when the panel shows up
			$UI/TextPanel.show()
		Game_State.PLAYING:
			$Player.controlling = true
			if TextManager.text_queue:
				current_state=Game_State.READING
				var text = TextManager.text_queue.pop_front()
				print("message: "+text)
				$UI/TextPanel.show_message(text)
		Game_State.READING:
			$Player.controlling = false
		Game_State.TYPING:
			$Player.controlling = false
			$UI/CodeEntryBox.show_panel()
		Game_State.GAME_WON:
			$Player.controlling = false
		Game_State.GAME_OVER:
			print("GAME OVER. ")
	if next_state: 
		current_state = next_state
		next_state = null

	#udpate timer on corner of screen
	$UI/TimerCorner/TimeLeft.set_text(str(int($UI/Clock.time_left)))


#--------Events------------------------------------------------------------
func _on_pickable_picked_up(my_name: String, carried: bool) -> void:
	print("Picking up " + my_name)
	if carried:
		var carried_item = $Player/CarryItem.get_child(0)
		carried_item.reparent($PickupItems)
		carried_item.position.x+=10
		carried_item.position.y+=10
		
		$Player.carrying = false

	else:	
		var pickup_item = get_node("PickupItems/"+my_name)
		pickup_item.reparent($Player/CarryItem)
		pickup_item.position = Vector2.ZERO
		$Player.carrying = true


func _on_move_through_door(to_bunker: bool) -> void:
	if to_bunker and current_state == Game_State.PLAYING: 
		$Player.global_position = $BunkerStairs.global_position # move character to bunker
		$BunkerCamera.make_current()
	elif current_state == Game_State.PLAYING:
		# move character to just outside door
		$Player.position = $BunkerDoor.global_position
		$Player/Camera2D.make_current()



func _on_enter_code_requested() -> void:
	print("Entering Code: ")
	next_state = Game_State.TYPING
	$UI/CodeEntryBox.show_panel()


func _on_clock_game_over() -> void:
	#Handle resetting the whole game
	current_state=Game_State.NEW_GAME
	
	get_tree().change_scene_to_file("res://examples/scenes/menus/main_menu/main_menu.tscn") #to return to main menu
	


func _on_code_entry_submitted(new_text: String) -> void:
	print("Code entered is "+new_text)
	$UI/CodeEntryBox.visible = false
	var correctCode = $UI/Clock.enterCode(new_text)
	if correctCode: 
		print("Correct code entered")
		if len(new_text)==10:
			print("Full code has been entered!")
			$BunkerItems.get_node("HiddenDoor").turn_on()
			$Map/SecretDoor.enabled = false
			$UI/Clock.stop_timing()
			
	else:
		print("Code was incorrect")
		$UI/TextPanel.show_message("Crap, that didn't work.")
		TextManager.push_item_texts("Hopefully nobody here listens to cybersecurity advice, and they've written the code down somewhere...")
		current_state = Game_State.READING
		return
	current_state = Game_State.PLAYING


	


func _on_safe_text_submitted(no1,no2,no3) -> void:
	var safecode = str(no1)+str(no2)+str(no3)
	print("Safe text submitted: "+safecode)
	current_state = Game_State.READING
	
	if safecode == $UI/Clock.SafeCode:
		$UI/TextPanel.show_message("It's opening!")
		$BunkerItems/Safe.code_success()
	else:
		print("Nope")
		$UI/TextPanel.show_message("That doesn't seem to have worked.")
		$BunkerItems/Safe.code_failure()

func _on_reveal_hidden_room() -> void:
	print("Revealing the hidden room")
	$SecretCamera.make_current()
	#var tween = get_tree().create_tween()


func _on_game_won() -> void:
	current_state = Game_State.GAME_WON


func _on_cinematic_finished() -> void:
	pass

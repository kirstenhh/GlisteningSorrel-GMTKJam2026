extends Timer

var MachineCode = ResetCodes()
var SafeCode = ResetSafeCode()
signal GameOver
func ResetCodes() -> String:
	var val = ""
	for i in range(10):
		val+= str(randi_range(1,9))
	print("Code is: "+val)
	
	return val
func ResetSafeCode() -> String:
	var val = ""
	for i in range(6):
		val+= str(randi_range(1,9))
	print("safe Code is: "+val)
	
	return val
	

## Returns to position of the number, still a String
# Consider 1st character is at position 0
func GetCodeNumber(pos: int) -> String:
	return MachineCode[pos]

func enterCode(code: String):
	
	#check each number
	if len(code)>=4 and len(code)<=10:
		if code == MachineCode.substr(0, len(code)):
			wait_time = len(code)*27
			start()
			return true
	return false
	#for n in len(code):
		#print(n," digit,",MachineCode[n],"=?",code[n])
		#if MachineCode[n] == code[n]:
			#print(n," digits correct")
			#corrects = n
		#else:
			#return
	#After checking, add time on each valid correct values
	#usually with the 4 base values you'd get 108, we need to modify if that's the case

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$TimeLeft.set_text(str(int(time_left)))
	pass

func _on_timeout() -> void:
	print("Timeout! end of the game")
	#implement white flash
	$WhiteLight/Flash.play("BuildupAndFlash")
	$WhiteLight.color.a=0
	$WhiteLight.visible=true
	await $WhiteLight/Flash.animation_finished
	TextManager.text_queue.push_back("You have not entered the code in time, the world as we know it ended")
	TextManager.text_queue.push_back("Press a button to go to the main menu")
	
	GameOver.emit()
	#resets game
	#get_tree().reload_current_scene() #to reset game
	
	
	#both should set new codes
	

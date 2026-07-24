extends Timer

var MachineCode = ResetCodes()

func ResetCodes() -> String:
	var val = randi_range(1000000000,9999999999)
	return str(val)
	
## Returns to position of the number, still a String
# Consider 1st character is at position 0
func GetCodeNumber(pos: int) -> String:
	return MachineCode[pos]

func enterCode(code: String) -> void:
	#base code is static, will need to implement random code digits
	
	#check each number
	var corrects = 0
	for n in len(code):
		print(n," digit,",MachineCode[n],"=?",code[n])
		if MachineCode[n] == code[n]:
			print(n," digit correct")
			corrects = n
		else:
			#don't reset/increase time if the password is wrong
			#Maybe implement a failure mode thingy?
			return
	#After checking, add time on each valid correct values
	#usually with the 4 base values you'd get 108, we need to modify if that's the case
	wait_time = (corrects+1)*27
	start()

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
	
	$WhiteLight.visible=true
	await $WhiteLight/Flash.animation_finished
	#resets whole Main scene
	get_tree().reload_current_scene()
	#sets new codes
	
	print("new code is ",MachineCode)

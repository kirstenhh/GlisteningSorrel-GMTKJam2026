extends Timer

@export var MachineCode = "4815162342"

func ResetCodes() -> String:
	return "4815162342"

func enterCode(code: String) -> void:
	#base code is static, will need to implement random code digits
	var finalcode = "4815162342"
	#check each number
	var corrects = 0
	for n in 10:
		print(n," digit,",finalcode[n],"=?",code[n])
		if finalcode[n] == code[n]:
			print(n," digit correct")
			corrects = n
		else:
			break
	#After checking, add time on each valid correct values
	wait_time = 108+corrects*30
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
	MachineCode = ResetCodes()

extends Node

var text_queue = []
# Called when the node enters the scene tree for the first time.

var text_sets = {
	"Bookshelf": ["There's a strange book here! It's missing a page...","The previous page has some text, though.", "It says, 'Turn the safe dial clockwise, counterclockwise", "and clockwise to the following values: ...","Then the torn page. The rest of the book is empty."],
	#Digits 1-4
	"Calendar": ["A wall calendar for September 2004.", "Oh! There's a torn Post-it here: ","The starting code is $code0 $code1 $code2 $code3 ..."],
	"Speaker": ["That's a big speaker, there's an Amp, but where is the CD player?"],
	"Projector": ["Oh, a Super-8 film Projector, those things are OLD!", "I wonder where i could find a film? Maybe in the Bunker?"],
	"Film": ["Ah a Super-8 film casette, the label says: 'Instructions for Jack'"],
	"Photo": ["A team photo... Hey that's me! Where are the other people on that picture?","The back of the picture has my handwriting! it says 'Best Team in Dharma, project Zaffer Pearl, taken by Ben'"],
	#Digit 5
	"PostIt":["Oh that's a similar Post-it Note from the one on the calenar!","It only has a number on it, $code4"],
	#Digit 6
	"Deck": ["Great! a Deck of playing cards! I can play Solitaire while waiting for the countdown","Ah Crap, all the $code5 are missing, who would remove exactly those?"],
	#Digit 7
	"Vinyl": ["A Vinyl Disk! 'The Top $code6 rock songs of 2004' Great!","I wonder if Driveshaft is in there? Shame I don't have a record player. I'll put it by the speaker for now."],
	"Player": ["Ah a Vinyl Player! I bet I can connect it to the Speaker to get some music"],
	#Digit 8
	"Beethoven": ["Hold on, this isn't Rock & Roll, That's Beethoven $code7th Symphony !?","Why would someone put that label on such a disk?"],
	"Key": ["That's a rather small key, definitely not for a door, maybe a padlock?"],
	"Drive": ["Hey that's a floppy disk! The label says 'Test Results August'"]
}
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func push_item_texts(item_name: String, code= ""):
	var current_texts = text_sets[item_name]
	for text in current_texts:
		text_queue.push_back(text)

extends Node

var text_queue = []
# Called when the node enters the scene tree for the first time.

var text_sets = {
	"Bookshelf": ["There's a strange book here! It's missing a page...","The previous page has some text, though.", "It says, 'Turn the safe dial clockwise, counterclockwise", "and clockwise to the following values: ...","Then the torn page. The rest of the book is empty."],
	#Digits 1-4
	"Calendar": ["A wall calendar for September 2004.", "Oh! There's a torn Post-it here: ","The starting code is $code0 $code1 $code2 $code3 ..."],
	"Projector": ["Oh, a Super-8 film Projector, those things are OLD!", "I wonder where i could find a film? Maybe in the Bunker?"],
	"Film": ["Ah a Super-8 film casette, the label says: 'Instructions for Jack'"],
	"Photo": ["A team photo... Hey that's me! Where are the other people on that picture?","The back of the picture has my handwriting! it says 'Best Team in Dharma, project Zaffer Pearl, taken by Ben'"],
	#Digit 5
	"PostIt":["Oh that's a similar Post-it Note from the one on the calenar!","It only has one number on it, $code4"],
	#Digit 6
	"Deck": ["Great! a Deck of playing cards! I can play Solitaire while waiting for the countdown","Ah Crap, all the $code5 are missing, who would remove exactly those?"],
	#Digit 7
	"Vinyl": ["A Vinyl record! 'The Top $code6 rock songs of 2004' Great!","I wonder if Driveshaft is in there? Shame I don't have a record player. I'll put it by the speaker for now."],
	"Player": ["Ah a Vinyl Player! I bet I can connect it to the speaker and play that rock album I found."],
	#Digit 8
	"Speaker": ["That's a big speaker, there's an Amp, but where is the CD player?"],
	"Speaker-first":["I put the record over here.", "The cover says it's the Top $code6 Rock Songs of 2004", "I really wish I could play it."],
	"Speaker-second":["I've got a great sound setup here!", "A real old-school system...", "Now if only I had something to play on it."],
	"Speaker-unlocked": ["Hold on, this isn't Rock & Roll, That's Beethoven Symphony No. $code7 !?","Why would someone put this in the sleeve for my rock album?"],
	"Key": ["That's a rather small key, definitely not for a door, maybe a padlock?"],
	"Drive": ["Hey that's a floppy disk! The label says 'Test Results August'"],
	"FilingCabinet": ["A filing cabinet! Maybe I can see what we were working on!", "...", "Oh, it's locked."],
	"FilingCabinet-unlocked": ["It's the right key! Awesome!", "Wow, this thing's really empty.", "There's just one sheet for 'ZAFFER':", "WARNING: Proximity to the Zaffer Pearl during tapping is highly dangerous.", "Side effects include: severe memory loss, disorientation, and fabric disintegration.", "Side effects of close contact also include: Death.", "Charming."],
	"Centrifuge": ["That's an Atomic Centrifuge... How do I know it's an Atomic Centrifuge?"],
	"PaperScrap": ["There's a scrap of blank paper here. Weird.", "Also, it smells lemony?" ],
	"Candle": ["There's a candle and matches here. Wonder what that's for."],
	"Candle-unlocked":["Hah, called it!", "Lemon juice invisible ink!", "The message reads, ", "'The '"]
}
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func push_item_texts(item_name: String):
	if item_name in text_sets:
		var current_texts = text_sets[item_name]
		for text in current_texts:
			text_queue.push_back(text)
	else: 
		text_queue.push_back(item_name)

func reset():
	text_queue = []

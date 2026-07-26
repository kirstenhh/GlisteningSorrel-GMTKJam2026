extends Node

var text_queue = []
# Called when the node enters the scene tree for the first time.

var text_sets = {
	"Bookshelf": ["There's a strange book here! It's missing a page...","The previous page has some text, though.", "It says, 'Turn the safe dial clockwise, counterclockwise", "and clockwise to the following values: ...","Then the torn page. The rest of the book is empty."],
	#Digits 1-4
	"Calendar": ["A wall calendar for September 2004.", "Oh! There's a torn Post-it here: ","The starting code is $code0 $code1 $code2 $code3 ...", "and then the end is torn off."],
	#Digit 5
	"PostIt":["Oh that's the rest of the Post-it Note on the calendar!","It only has one number on it, $code4"],
	#Digit 6
	"Vinyl": ["A Vinyl record! 'The Top $code5 rock songs of 2004' Great!","I wonder if Driveshaft is in there? Shame I don't have a record player. I'll put it by the speaker for now."],
	#Digit 7
	"Deck": ["Great! a Deck of playing cards! I can play Solitaire while waiting for the countdown","Ah Crap, all the $code6 are missing, who would remove exactly those?"],
	#Digit 8
	"Speaker": ["That's a big speaker, there's an even an amp.","but where could the CD player be?"],
	"VinylPlayer": ["Ah a Vinyl Player! I bet I can connect it to the speaker and play that rock album I found."],
	"Speaker-first":["I put the record over here.", "The cover says it's the Top $code6 Rock Songs of 2004", "I really wish I could play it."],
	"Speaker-second":["I've got a great sound setup here!", "A real old-school system...", "Now if only I had something to play on it."],
	"Speaker-unlocked": ["Hold on, this isn't Rock & Roll, That's Beethoven Symphony No. $code7 !?","Why would someone put this in the sleeve for my rock album?"],
	#Digit 9
	"MP3Player": ["Hey, it's an MP3 player! With earphones, even!","wasn't expecting to find this in the forest.", "Finally, some music!", "...","Aaaaand it's just someone repeating '$code8, $code8, $code8' over and over again.", "Actually, that voice sounds familiar.", "Is that ME???"],
	#Digit 10 
	"Safe":["Huh, a safe. Looks like it's locked.", "Wonder what's inside?"],
	"JournalPage": ["This must be the missing page from that journal!", "It says: $safe0$safe1 $safe2$safe3 $safe4$safe5.", "Now I can finally see what's in the safe!"],
	"Safe-unlocked":["Wow, this safe is full of equipment!", "I have no idea what that thing is, but it looks like a tricorder dunked in warning paint.", "Oh, there's a number on the inside of the door!", "It says, '$code9', and under it:", "And to hell with you all."],
	
	#----Clues------------------------------------
	
	"Photo": ["A team photo... Hey that's me! Where are the other people on that picture?","The back of the picture has my handwriting! it says 'Best Team in Dharma, project Zaffer Pearl, taken by Ben'"],
	
	"Centrifuge": ["That's an Atomic Centrifuge... How do I know it's an Atomic Centrifuge?"],
	
	"VideoPlayer": ["Oh, a VHS Player! I feel nostalgic already", "I wonder where I could even find a cassette for it..."],
	"Film": ["Awesome, a VHS cassette! That's convenient.","The label says: 'Instructions for Jack'."],
	"VideoPlayer-unlocked":["It worked!", "There's a woman on the screen.", "'Whoever's watching this, we're in big trouble. Jack, I hope you make it out.", "But if not, the next person has to know what to do.", "You have to enter the code and keep the cycler running.", "The correct code gives you more time between cycles the longer it is,","And the 10-digit code will shut off the cycler tap completely."],
	
	"Key": ["That's a rather small key, definitely not for a door, maybe a padlock?"],
	"FilingCabinet": ["A filing cabinet! Maybe I can see what we were working on!", "...", "Oh, it's locked."],
	"FilingCabinet-unlocked": ["It's the right key! Awesome!", "Wow, this thing's really empty.", "There's just one sheet for 'ZAFFER':", "WARNING: Proximity to the Zaffer Pearl during tapping is highly dangerous.", "Side effects include: severe memory loss, disorientation, and fabric disintegration.", "Side effects of close contact also include: Death.", "Charming."],
	
	"Map": ["A map of the island.", "Not especially useful:","it's just beach, forest, mountain, and right at the top:","An X.", "Classic."],
	
	"Drive": ["Hey that's a floppy disk! The label says 'Test Results August'"],
	"PersonalComputer":["It's working, but there are no files on it.","It looks like a new installation.","Of an absolutely ancient system.","What the heck is HaikuOS???"],
	"PersonalComputer-unlocked":["This drive seems to be full of records of tests", "Mostly power measurements.","TODO this needs to be another clue!"],
	
	"Cabin" : ["A wooden cabin !? hold on... I seem to remember Oscar was making a lot of trips outside. Is that what he was doing?","Dumbass forgot about the door... how was he the Chief Engineer?"], 
	"GameWon": ["If you're reading this, you turned off the invisibility generator.", "You should not have done that.", "They'll be coming for you.","They sent Ben to try and sabotage us, so they could get access.","Now they can find you.", "Run, and don't look back."],
	# Misc Texts
	"BenLocker": ["The label on this locker says 'Benjamin'"],
	"Shelf": ["Hmmm, 'Valis', 'After All These Years', 'Our Mutual Friend', ","quite the book collection! Doesn't seem to have any Stephen King..."]
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

func DisplayLine()->void:
	pass

func reset():
	text_queue = []

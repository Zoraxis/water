extends Node2D

var text = "PENIS"
var currSymbol = 0
var textDelay = 0
var textmaxDelay = 1
var distance = 300

func setNewText(newText):
	text = newText
	currSymbol = 0

func _process(delta):
	if distance > 0:
		distance -= 5
		position.y += 5
	
	if textDelay <= 0 and currSymbol < text.length() and distance <= 0:
		$text.text += text[currSymbol]
		currSymbol += 1
		textDelay = textmaxDelay
	
	textDelay -= delta * 4

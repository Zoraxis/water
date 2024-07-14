extends Node2D

var text = " "
var currSymbol = 0

var textDelay = 0
var textmaxDelay = 1

func setNewText(newText):
	text = newText
	currSymbol = 0

func _process(delta):
	
	if textDelay <= 0 and currSymbol < text.length():
		$text.text += text[currSymbol]
		currSymbol += 1
		textDelay = textmaxDelay
	
	textDelay -= delta * 8

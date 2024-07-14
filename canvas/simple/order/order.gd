extends Node2D

var text = "PENIS"
var currSymbol = 0
var textDelay = 0
var textmaxDelay = 1

var movement = false

var destroying = false

func _ready():
	$moving.targetYPos = 300

func setNewText(newText):
	text = newText
	currSymbol = 0
	
func selfDestruct():
	destroying = true
	movement = true
	$moving.targetYNeg = 300
	
func moveLeft():
	$moving.targetXNeg = 350

func _process(delta):
	if movement:
		return
	
	if destroying:
		queue_free()
		return
	
	if textDelay <= 0 and currSymbol < text.length() and not movement:
		$text.text += text[currSymbol]
		currSymbol += 1
		textDelay = textmaxDelay
	
	textDelay -= delta * 4

extends Node2D

var targetYPos = 0
var targetYNeg = 0
var targetXNeg = 0

@export var SPEED = 5

func _process(delta):
	var noMovement = true
	
	if targetXNeg > 0:
		targetXNeg -= SPEED
		get_parent().position.x -= SPEED
		noMovement = false
		
	if targetYPos > 0:
		targetYPos -= SPEED
		get_parent().position.y += SPEED
		noMovement = false
		
	if targetYNeg > 0:
		targetYNeg -= SPEED
		get_parent().position.y -= SPEED
		noMovement = false
		
	get_parent().movement = !noMovement

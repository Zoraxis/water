extends Node2D

@export var distance = 3.55

var state = false

func toggle(newState):
	state = newState

func _process(delta):
	if distance > 0 and state:# Input.is_action_pressed("ui_accept"):
		position = Vector2(position.x, position.y - 5 * delta)
		distance -= delta

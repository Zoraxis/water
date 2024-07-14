extends Node2D

@export var distance = 3.55
var currentDistance = 0
var startingPosY = 0
var state = false

func _ready():
	startingPosY = position.y

func update_pos(progress):
	currentDistance = progress * distance

func _process(delta):
	position.y = startingPosY + currentDistance

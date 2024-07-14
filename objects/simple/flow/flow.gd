extends StaticBody2D

@export var color: Color = Color.WHITE

func _ready():
	$animation.play("flow")
	$animation.modulate = color

func _process(delta):
	move_and_collide(Vector2(0, 0))
	
func set_color(newColor: Color):
	color = newColor
	$animation.modulate = color

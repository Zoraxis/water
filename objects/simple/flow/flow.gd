extends StaticBody2D

func _ready():
	$animation.play("flow")

func _process(delta):
	move_and_collide(Vector2(0, 0))

extends StaticBody2D

func _ready():
	$animation.play("flow")

func _process(delta):
	move_and_collide(Vector2(0, 0))

func set_color(color: Color):
	$animation.modulate = color

func start_pouring():
	self.set_process(true)
	visible = true
 
func stop_pouring():
	self.set_process(false)
	visible = false
	
func get_color():
	return $animation.modulate

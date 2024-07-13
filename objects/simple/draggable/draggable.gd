extends Area2D

var dragged = 0;
var braking = 0;
var pickUpOffset = Vector2(0, 0)

func _physics_process(delta):
	if dragged > 0:
		position = get_global_mouse_position() + pickUpOffset
		dragged -= braking
	else:
		braking = 0
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_released():
		braking = 1;
	if event is InputEventMouseButton and event.is_pressed():
		dragged = 10;
		pickUpOffset = position - get_global_mouse_position()

extends StaticBody2D

@export var capacity = 100.0
var filled = 0

var dragged = 0;
var braking = 0;
var pickUpOffset = Vector2(0, 0)

func _process(delta):
	if $mask_ziza/ziza.state == true:
		filled += delta * 2

func _on_in_body_entered(body):
	$mask_ziza/ziza.toggle(true)

func _on_in_body_exited(body):
	$mask_ziza/ziza.toggle(false)

func _physics_process(delta):
	if dragged > 0:
		position = get_global_mouse_position() + pickUpOffset
		dragged -= braking
	else:
		braking = 0

func _on_draggable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_released():
		braking = 1;
	if event is InputEventMouseButton and event.is_pressed():
		dragged = 10;
		pickUpOffset = position - get_global_mouse_position()

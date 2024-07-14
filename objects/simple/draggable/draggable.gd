extends Area2D

var dragged = 0;
var braking = 0;
var pickUpOffset = Vector2(0, 0)
var pickUpPos = Vector2(0, 0)
var placable = false

func _physics_process(delta):
	if dragged:
		get_parent().get_parent().get_parent().position = get_global_mouse_position() + pickUpOffset

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.as_text().begins_with("Left") and event.is_released():
		dragged = false
		G.dragged = false
		if get_parent().get_parent().is_in_group("GLASS"):
			get_parent().get_parent().drag_stop()
		if not placable:
			get_parent().get_parent().get_parent().position = pickUpPos
			placable = true
	if event is InputEventMouseButton and event.as_text().begins_with("Left") and event.is_pressed() and not G.dragged:
		dragged = true
		G.dragged = true
		pickUpPos = get_parent().get_parent().get_parent().position
		pickUpOffset = get_parent().get_parent().get_parent().position - get_global_mouse_position()

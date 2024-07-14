extends Area2D

func _on_body_entered(body):
	if body.is_in_group("DRAG"):
		body.get_node("vesselHolder").get_node("draggable").placable = true

func _on_body_exited(body):
	if body.is_in_group("DRAG"):
		body.get_node("vesselHolder").get_node("draggable").placable = false

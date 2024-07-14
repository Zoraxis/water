extends Area2D

@export var isNapkin = true

func _on_body_entered(body):
	if body.is_in_group("DRAG") and body.is_in_group("GLASS"):
		if isNapkin:
			body.isOnNapkin = true
		body.get_node("vesselHolder").get_node("draggable").placable = true

func _on_body_exited(body):
	if body.is_in_group("DRAG") and body.is_in_group("GLASS"):
		if isNapkin:
			body.isOnNapkin = false
		body.get_node("vesselHolder").get_node("draggable").placable = false

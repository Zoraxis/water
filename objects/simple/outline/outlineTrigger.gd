extends Area2D

var outlineMaterial = preload("res://objects/simple/outline/outline.tres")

func toggleParentOutline(on):
	if on:
		get_parent().material = outlineMaterial
	else:
		get_parent().material = null

func _on_mouse_entered():
	toggleParentOutline(true)
func _on_mouse_exited():
	toggleParentOutline(false)

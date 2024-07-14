extends Area2D

var outlineMaterial = preload("res://objects/simple/outline/outline.tres")

func toggleParentOutline(on):
	if on:
		get_parent().material = outlineMaterial
	else:
		get_parent().material = null

func _process(delta):
	if G.outlined.size() != 0:
		if (G.outlined[0] == get_instance_id()):
			toggleParentOutline(true)
		else:
			toggleParentOutline(false)
	else:
		toggleParentOutline(false)

func _on_mouse_entered():
	G.outlined.append(get_instance_id())
func _on_mouse_exited():
	G.outlined.remove_at(G.get_index(get_instance_id()))
	toggleParentOutline(false)

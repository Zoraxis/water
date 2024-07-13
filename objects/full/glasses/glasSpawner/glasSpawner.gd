extends Area2D

@export var glass: PackedScene

var removed = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and not removed:
		G.updateMoney(-1)
		removed = true
		await U.delay(0.3)
		removed = false
		var instance = glass.instantiate()
		instance.position = position
		get_parent().add_child(instance)

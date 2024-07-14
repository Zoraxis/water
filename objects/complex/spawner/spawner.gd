extends Area2D

@export var glass: PackedScene
@export var price = 1

var removed = false

func _ready():
	$price.text = str(price)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.as_text().begins_with("Left") and event.is_pressed() and not removed:
		G.updateMoney(-1 * price)
		removed = true
		await U.delay(0.3)
		removed = false
		var instance = glass.instantiate()
		instance.position = Vector2(750, 750)
		get_parent().add_child(instance)

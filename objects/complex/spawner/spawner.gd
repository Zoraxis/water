extends Area2D

@export var glass: PackedScene
@export var price = 1
@export var red = false

var removed = false

func _ready():
	$price.text = str(price)
	if red:
		$Stand.visible = false
		$Stand2.visible = true

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.as_text().begins_with("Left") and event.is_pressed() and not removed:
		if G.updateMoney(-1 * price):
			removed = true
			await U.delay(0.3)
			removed = false
			var instance = glass.instantiate()
			instance.position = Vector2(randf_range(800, 1200), randf_range(600, 900))
			get_parent().add_child(instance)

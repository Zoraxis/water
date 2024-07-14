extends Node


var orders = G.newOrder()
@export var order_scene_path: String = "res://canvas/simple/order/order.tscn"


func _ready():
	var order_scene: PackedScene = load(order_scene_path)
	
	for i in range(3):
		var order_instance = order_scene.instantiate()
		var label_node = order_instance.get_node("text")
		label_node.text = str(orders[i]["text"])
		order_instance.position = Vector2(350 * i, 100)
		add_child(order_instance)

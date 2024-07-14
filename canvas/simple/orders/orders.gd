extends Node

@export var order_scene: PackedScene = preload("res://canvas/simple/order/order.tscn")

var orders = []
var futureOrders = [
	{
		"text": "Blue",
		"color": Color.BLUE,
		"strength": 3,
	},
		{
		"text": "Brown",
		"color": Color.BROWN,
		"strength": 3,
	},
	{
		"text": "Yellow",
		"color": Color.YELLOW,
		"strength": 3,
	},
	{
		"text": "White",
		"color": Color.WHITE,
		"strength": 3,
	}
]
func _ready():
	G.orders = self
	timeline()
	
func timeline():
	newOrder();
	await U.delay(3)
	newOrder();
	await U.delay(3)
	newOrder();
	await U.delay(3)

func newOrder():
	var appendedOrder = futureOrders[0]
	orders.append(appendedOrder)
	addOrder(appendedOrder)
	futureOrders.remove_at(0)

func addOrder(order):
	var order_instance = order_scene.instantiate()
	order_instance.setNewText(str(order["text"]))
	order_instance.position = Vector2(350 * (orders.size() - 1), -200)
	add_child(order_instance)

extends Node

@export var order_scene: PackedScene = preload("res://canvas/simple/order/order.tscn")

var orders = []
var futureOrders = [
	{
		"text": "Blue",
		"color": Color.BLUE,
		"money": 3,
	},
		{
		"text": "Brown",
		"color": Color.BROWN,
		"money": 3,
	},
	{
		"text": "Yellow",
		"color": Color.YELLOW,
		"money": 3,
	},
	{
		"text": "White",
		"color": Color.WHITE,
		"money": 3,
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
	order["instance"] = order_instance
	add_child(order_instance)
	
func resolveOrder(color, object):
	for i in range(orders.size()):
		if(U.colorCompare(orders[i].color as Color,color, 1)):
			G.updateMoney(orders[i].money)
			orders[i]["instance"].selfDestruct()
			for j in range(i, orders.size()):
				orders[j]["instance"].moveLeft()
			orders.remove_at(i)
			await U.delay(0.2)
			object.queue_free()
			return

	await U.delay(0.2)
	object.queue_free()

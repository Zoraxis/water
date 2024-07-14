extends Node

@export var order_scene: PackedScene = preload("res://canvas/simple/order/order.tscn")

var baseOrder = {
	"text": "Base",
	"color": Color.WHITE,
	"money": 1,
}

var orders = []
var futureOrders = [
	{
		"text": "Blue",
		"color": Color.BLUE,
		"money": 2,
	},
		{
		"text": "Brown",
		"color": Color.BROWN,
		"money": 1,
	},
	{
		"text": "Yellow",
		"color": Color.YELLOW,
		"money": 2,
	},
	{
		"text": "White",
		"color": Color.WHITE,
		"money": 3,
	},
	{
		"text": "Green",
		"color": Color.GREEN,
		"money": 3,
	}
]
func _ready():
	G.orders = self
	var random_order = get_random_orders()
	futureOrders = random_order
	newOrder();
	await U.delay(3)
	newOrder();
	await U.delay(3)
	newOrder();
	await U.delay(3)
	newOrder();
	await U.delay(3)

func get_random_orders():
	var orders = []
	for i in range(50):
		var random_order = get_random_order()
		orders.append(random_order)
	return orders

func get_random_order():
	var random_index = randi() % futureOrders.size()
	var random_future_order = futureOrders[random_index]
	
	var combined_order = baseOrder.duplicate()
	combined_order["text"] = random_future_order["text"]
	combined_order["color"] = random_future_order["color"]
	combined_order["money"] += random_future_order["money"]	
	
	return combined_order
	
func timeline():
	await U.delay(1.5)
	newOrder();

func newOrder():
	var appendedOrder = futureOrders[0]
	orders.append(appendedOrder)
	var order_instance = order_scene.instantiate()
	print(appendedOrder)
	order_instance.setNewText(str(appendedOrder["text"]))
	order_instance.position = Vector2(350 * (orders.size() - 1), -200)
	appendedOrder["instance"] = order_instance
	add_child(order_instance)
	futureOrders.remove_at(0)
	
	
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
			timeline()
			return

	await U.delay(0.2)
	object.queue_free()

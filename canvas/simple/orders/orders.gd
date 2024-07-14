extends Node

@export var order_scene: PackedScene = preload("res://canvas/simple/order/order.tscn")

var maxType = 0
var iteration = 0

var types = [
	preload("res://objects/full/glasses/glas1/glas.png"),
	preload("res://objects/full/glasses/beach/Beach.png"),
	preload("res://objects/full/glasses/cognac/Cognac.png"),
	preload("res://objects/full/glasses/martini/Martini.png"),
]

var baseOrder = {
	"text": "Base",
	"color": Color.WHITE,
	"money": 1,
	"type": 0,
	"typeNum": 0
}

var orders = []
var futureOrders = [
	{
		"text": "Blue",
		"color": Color.BLUE,
		"money": 2,
		"type": 0,
		"typeNum": 0
	},
		{
		"text": "Brown",
		"color": Color.BROWN,
		"money": 1,
		"type": 0,
		"typeNum": 0
	},
	{
		"text": "Yellow",
		"color": Color.YELLOW,
		"money": 2,
		"type": 0,
		"typeNum": 0
	},
	{
		"text": "White",
		"color": Color.WHITE,
		"money": 3,
		"type": 0,
		"typeNum": 0
	},
	{
		"text": "Green",
		"color": Color.GREEN,
		"money": 3,
		"type": 0,
		"typeNum": 0
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
	var randomType = randi_range(0, maxType)
	combined_order["type"] = types[randomType]
	combined_order["typeNun"] = randomType
	
	return combined_order
	
func timeline():
	iteration += 1
	await U.delay(1.5)
	newOrder();
	
	if iteration == 2:
		maxType = 1
	if iteration == 5:
		maxType = 2
	if iteration == 8:
		maxType = 2
	if iteration == 10:
		maxType = 3

func newOrder():
	var appendedOrder = futureOrders[0]
	orders.append(appendedOrder)
	var order_instance = order_scene.instantiate()
	print(appendedOrder)
	order_instance.setNewText(str(appendedOrder["text"]))
	order_instance.position = Vector2(350 * (orders.size() - 1), -200)
	order_instance.type = appendedOrder["type"]
	order_instance.typeNum = appendedOrder["typeNum"]
	appendedOrder["instance"] = order_instance
	add_child(order_instance)
	futureOrders.remove_at(0)
	
func resolveOrder(color, object):
	if object.filled < 0.5:
		await U.delay(0.2)
		object.queue_free()
		return
	
	for i in range(orders.size()):
		if(orders[i]["typeNum"] == object.typeNum):
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

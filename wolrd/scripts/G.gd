extends Node

var money = 10;

var dragged = false;
var outlined = [];

func updateMoney(value):
	money += value

var orders = [
	{
		"text": "Brown",
		"strength": 3,
	},
	{
		"text": "Yellow",
		"strength": 3,
	},
	{
		"text": "White",
		"strength": 3,
	}
]

var futureOrders = [
	{
		"text": "Blue",
		"strength": 3,
	}
]


func newOrder():
	orders.append(futureOrders[0])
	futureOrders.remove_at(0)
	return orders

extends Node

var money = 10;

func updateMoney(value):
	money += value

var orders = [
	{
		"text": "sth strong",
		"strength": 3,
	}
]

var futureOrders = [
	{
		"text": "sth very strong",
		"strength": 3,
	}
]


func newOrder():
	orders.append(futureOrders[0])
	futureOrders.remove_at(0)
	return orders

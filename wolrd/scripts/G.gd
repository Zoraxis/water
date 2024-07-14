extends Node

var money = 10;

var dragged = false;
var outlined = [];

func updateMoney(value):
	if money + value < 0:
		return false
	money += value
	coinLabel.alterText()
	return true
	
func gameOver():
	get_tree().change_scene_to_file("res://world/world.tscn")

var orders = null
var coinLabel = null
var current_hp

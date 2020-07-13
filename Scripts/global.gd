extends Node

var cpad = false
var HP = 100
var hp_max = 100
var time_for_1 = 0
var time_for_2 = 0
var time_for_3 = 0
var items_collected = Array()
var items_to_collect = Array()
var items = ['apple', 'battery', 'bread', 'colddrink', 'icecream', 'milk', 'tpaper']

func _ready():
	pass

func add_item(item):
	if items_collected.size() >= 4:
		throw_item()
	if item in items_collected:
		return
	items_collected.push_back(item)
	
func throw_item():
	items_collected.pop_front()
	
func display_items():
	print(items_collected)

func getname(idx):
	for name in items:
		if idx == 0:
			return "res://Resources/Icons/"+name+".png"
		idx-=1

func realname(idx):
	for name in items:
		if idx == 0:
			return name
		idx-=1

extends Node

var cpad = 0
var prot_index = 1
var HP = 100
var hp_max = 100
var time_for_1 = 0
var time_for_2 = 0
var time_for_3 = 0
var items_collected = Array()
var items_to_collect = Array()
var gold_collect = Array()
var total_gold = 0
var key_counts = 0
var red_key = false
var blue_key = false
var green_key = false
var exit_activated = false
var items = ['apple', 'battery', 'bread', 'colddrink', 'icecream', 'milk', 'tpaper']

var save_path = str("user://haunted_save.json")

var save_file = {
	'cpad': int(),
	'prot_index': int(),
	'total_gold': int()
}

func _ready():
	var save = File.new()
	var temp = {}
	if save.file_exists(save_path):
		save.open(save_path, File.READ)
		while save.get_position() < save.get_len():
			var data = parse_json(save.get_line())
			temp[temp.size()] = data
		cpad = int(temp[0])
		prot_index = int(temp[1])
		total_gold = int(temp[2])
		
	save_file['cpad'] = cpad
	save_file['prot_index'] = prot_index
	save_file['total_gold'] = total_gold
	
	save.close()

func add_item(item):
	if items_collected.size() > 4:
		return
	if item in items_collected:
		return
	items_collected.push_back(item)
	
func throw_item():
	items_collected.pop_front()

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

func save_in_file():
	var save = File.new()
	save.open(save_path, File.WRITE)
	save_file['cpad'] = cpad
	save_file['prot_index'] = prot_index
	save_file['total_gold'] = total_gold
	
	for i in save_file:
		save.store_line(to_json(save_file[i]))
		
	save.close()

func close_game():
	get_tree().quit()

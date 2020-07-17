extends Control


func _ready():
	Global.items_to_collect = Array()
	Global.items_collected = Array()
	Global.gold_collect = Array()
	Global.key_counts = 0
	Global.exit_activated = false
	Global.red_key = false
	Global.blue_key = false
	Global.green_key = false
	var item
	var rname
	var gold
	for i in range(5):
		randomize()
		item = int(rand_range(0, 7))
		gold  = int(rand_range(1, 20))
		while item in Global.items_to_collect:
			randomize()
			item = int(rand_range(0, 7))
		Global.items_to_collect.push_back(item)
		Global.gold_collect.push_back(gold)
		get_node("item"+str(i+1)).texture = load(Global.getname(item))
		var aname = ""
		rname = Global.items[item]
		for j in range(len(rname)):
			if j == 0:
				aname = aname + rname[j].to_upper()
			else:
				aname = aname + rname[j]
		get_node("item"+str(i+1)+"/Label").text = aname
		get_node("item"+str(i+1)+"/Label2").text = str(Global.gold_collect[i]) + " Gold"

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/cutscenes.tscn")

func _on_continue_button_pressed():
	$"select".play()
	$"FadeIn".visible = true
	$"FadeIn".fade_in()

extends Control

var scene_to_load

func _ready():
	var collected = 0
	var collected_no = 0
	$"gold/AnimationPlayer".play("rotate")
	for i in range(Global.items_to_collect.size()):
		if Global.items_to_collect[i] in Global.items_collected:
			collected += Global.gold_collect[i]
			collected_no += 1
	if Global.exit_activated:
		collected *= 3
	if collected_no == 5:
		collected *= 2
	$"no_gold".text = str(collected) + " Gold"
	Global.total_gold += collected
	Global.save_in_file()

func _on_play_again_button_pressed():
	$"select".play()
	scene_to_load = "res://Scenes/item_roulette.tscn"
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_go_to_menu_button_pressed():
	$"select".play()
	scene_to_load = "res://Scenes/menu.tscn"
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_to_load)

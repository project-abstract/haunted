extends Control

func _ready():
	pass 


func _on_back_pressed():
	$"select".play()
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/menu.tscn")

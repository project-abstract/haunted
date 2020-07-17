extends Control


func _ready():
	$"fade_out".fade_in()

func _on_fade_out_fade_finished():
	$"ghosts".start_dance()

func _on_ghosts_dance_done():
	$"FadeIn".visible = true
	$"FadeIn".fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/title_splash.tscn")

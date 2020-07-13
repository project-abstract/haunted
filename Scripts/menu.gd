extends Control

var scene_load

func _ready():
	$"gold_sprite/AnimationPlayer".play("rotate")
	if !OS.has_virtual_keyboard():
		$"startgame".grab_focus()

func _process(delta):
	pass

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	$"select".play()
	scene_load = $"credits".scene_to_load
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_customization_pressed():
	$"select".play()
	scene_load = $"customization".scene_to_load
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_startgame_pressed():
	$"select".play()
	scene_load = $"startgame".scene_to_load
	$"FadeIn".visible = true
	$"FadeIn".fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_load)


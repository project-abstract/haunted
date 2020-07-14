extends Control


func _ready():
	if !OS.has_virtual_keyboard():
		$"controller_settings/cpad".disabled = false 
		$"controller_settings/dpad".disabled = false
	else:
		$"controller_settings/cpad".disabled = false 
		$"controller_settings/dpad".disabled = false



func _on_back_pressed():
	$"select".play()
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/menu.tscn")


func _on_dpad_pressed():
	$"select".play()
	Global.cpad = false


func _on_cpad_pressed():
	$"select".play()
	Global.cpad = true

extends Control


func _ready():
	if !OS.has_virtual_keyboard():
		$"controller_settings/cpad".disabled = true 
		$"controller_settings/dpad".disabled = true
	else:
		$"controller_settings/cpad".disabled = false 
		$"controller_settings/dpad".disabled = false



func _on_back_pressed():
	$"FadeIn".visible = true
	$"FadeIn".fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Scenes/menu.tscn")


func _on_dpad_pressed():
	Global.cpad = false


func _on_cpad_pressed():
	Global.cpad = true

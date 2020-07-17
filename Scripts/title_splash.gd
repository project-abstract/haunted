extends Control

func _ready():
	$"haunted/AnimationPlayer".play("logo")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/menu.tscn")

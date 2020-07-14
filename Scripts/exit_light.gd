extends Light2D

func _ready():
	$"AnimationPlayer".play("super_lightswork")

func _process(delta):
	if Global.key_counts == 3:
		Global.exit_activated = true
		self.visible = true
	else:
		self.visible = false
		Global.exit_activated = false
	if Global.exit_activated:
		var bodies = str($"exit_area".get_overlapping_bodies())
		if "KinematicBody2D" in bodies:
			if Input.is_action_pressed("ui_accept"):
				get_tree().paused = true
				get_parent().menu_path = "res://Scenes/score_screen.tscn"
				get_parent().get_node("body/controls").visible = false
				get_parent().get_node("body/pause_screen/return_button").visible = false
				get_parent().get_node("body/pause_screen/paused_text").text = "You reached the Exit"
				get_parent().get_node("body/pause_screen/menu_button/Label").text = "Score"
				get_parent().get_node("body/pause_screen").visible = true

extends Sprite

func _ready():
	$"Light2D/AnimationPlayer".play("key_light")

func _process(delta):
	var bodies = str($"Area2D".get_overlapping_bodies())
	if "KinematicBody2D" in bodies and Input.is_action_pressed("ui_accept"):
		self.visible = false
		Global.blue_key = true

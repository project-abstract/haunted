extends Sprite

var idx = 0
var my_name = "apple"
export var distraction_time = 5

func _ready():
	$"Light2D/AnimationPlayer".play("blink")

func _process(delta):
	var bodies = str($"Area2D".get_overlapping_bodies())
	if "KinematicBody2D" in bodies and Input.is_action_pressed("ui_accept"):
		self.visible = false
		Global.add_item(idx)

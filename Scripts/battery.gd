extends Sprite

var idx = 1
var my_name = "battery"
export var distraction_time = 8

func _ready():
	$"Light2D/AnimationPlayer".play("blink")
	randomize()
	var x = rand_range(-1376, 3504)
	randomize()
	var y = rand_range(-936, 2768)
	get_parent().position = Vector2(x, y)

func _process(delta):
	var bodies = str($"Area2D".get_overlapping_bodies())
	if "KinematicBody2D" in bodies and Input.is_action_pressed("ui_accept") and Global.items_collected.size() <= 4:
		self.visible = false
		Global.add_item(idx)
	if "TileMap" in str($"Area2D".get_overlapping_bodies()):
		randomize()
		var x = rand_range(-1376, 3504)
		randomize()
		var y = rand_range(-936, 2768)
		get_parent().position = Vector2(x, y)

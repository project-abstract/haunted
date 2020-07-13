extends Sprite

var idx = 6
var my_name = "tpaper"
export var distraction_time = 13

func _ready():
	$"Light2D/AnimationPlayer".play("blink")
	randomize()
	var x = rand_range(-1512, 3328)
	randomize()
	var y = rand_range(-1696, 1992)
	get_parent().position = Vector2(x, y)

func _process(delta):
	var bodies = str($"Area2D".get_overlapping_bodies())
	if "KinematicBody2D" in bodies and Input.is_action_pressed("ui_accept"):
		self.visible = false
		Global.add_item(idx)
	if "TileMap" in str($"Area2D".get_overlapping_bodies()):
		randomize()
		var x = rand_range(-1512, 3328)
		randomize()
		var y = rand_range(-1696, 1992)
		get_parent().position = Vector2(x, y)

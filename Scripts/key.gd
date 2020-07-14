extends Sprite

func _ready():
	$"Light2D/AnimationPlayer".play("light_blink")

func _process(delta):
	var bodies = str($"Area2D".get_overlapping_bodies())
	if "KinematicBody2D" in bodies and Input.is_action_pressed("ui_accept"):
		self.visible = false
		Global.key_counts = 1
	if "TileMap" in str($"Area2D".get_overlapping_bodies()):
		randomize()
		var x = rand_range(-1376, 3504)
		randomize()
		var y = rand_range(-936, 2768)
		self.position = Vector2(x, y)

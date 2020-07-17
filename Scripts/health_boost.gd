extends Sprite

var health_heal = 30
var time_gone = 0
var eaten = true

func _ready():
	randomize()
	var x = rand_range(-1512, 3328)
	randomize()
	var y = rand_range(-1696, 1992)
	self.position = Vector2(x, y)

func _process(delta):
	if time_gone >= 10*delta:
		time_gone = 0
		if self.frame_coords == Vector2(1, 0):
			self.frame_coords = Vector2(0, 0)
		else:
			self.frame_coords = Vector2(1, 0)
	else:
		time_gone += delta
	if "KinematicBody2D" in str($"health_area".get_overlapping_bodies()):
		if Input.is_action_pressed("ui_accept") and Global.HP < Global.hp_max:
			Global.HP += health_heal
			randomize()
			var x = rand_range(-1512, 3328)
			randomize()
			var y = rand_range(-1696, 1992)
			self.position = Vector2(x, y)
			if Global.HP > Global.hp_max:
				Global.HP = Global.hp_max
			get_parent().get_parent().get_node("body").update_health()
	elif "TileMap" in str($"health_area".get_overlapping_bodies()):
		randomize()
		var x = rand_range(-1512, 3328)
		randomize()
		var y = rand_range(-1696, 1992)
		self.position = Vector2(x, y)

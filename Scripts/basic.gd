extends Node2D

onready var fps = $"body/fps_label/fps"
onready var nav_2d = $"Navigation2D"
onready var villian = $"Navigation2D/bhost"
onready var prota = $"body/prota"

func _process(delta):
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	
	var new_path = nav_2d.get_simple_path(villian.global_position, prota.global_position)
	villian.path = new_path

extends Node2D

onready var fps = $"body/fps_label/fps"
onready var nav_2d = $"Navigation2D"
onready var villian = $"Navigation2D/bhost"
onready var prota = $"body/prota"
var next_position = Vector2()
onready var hidden = false

func _process(delta):
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	
	var new_path = nav_2d.get_simple_path(villian.global_position, next_position)
	
	var x_diff = abs(villian.global_position.x-prota.global_position.x)
	var y_diff = abs(villian.global_position.y-prota.global_position.y)
	var distance_diff = sqrt(x_diff*x_diff + y_diff*y_diff)
	
	if distance_diff < 700.0 and hidden == false:
		next_position = prota.global_position
		$"Navigation2D/bhost".chasing = true
	else:
		$"Navigation2D/bhost".chasing = false
		next_position = Vector2(0, 0)
	if distance_diff < 70.0:
		fps.text = "You suck at this play again with FPS: " + str(Engine.get_frames_per_second())
	
	villian.path = new_path


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		hidden = true


func _on_Area2D_body_exited(body):
	if body is KinematicBody2D:
		hidden = false


func _on_Area2D2_body_entered(body):
	if body is KinematicBody2D:
		hidden = true


func _on_Area2D2_body_exited(body):
	if body is KinematicBody2D:
		hidden = false


func _on_Area2D3_body_entered(body):
	if body is KinematicBody2D:
		hidden = true


func _on_Area2D3_body_exited(body):
	if body is KinematicBody2D:
		hidden = false


func _on_Area2D4_body_entered(body):
	if body is KinematicBody2D:
		hidden = true


func _on_Area2D4_body_exited(body):
	if body is KinematicBody2D:
		hidden = false

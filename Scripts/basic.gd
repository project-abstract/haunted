extends Node2D

onready var fps = $"body/fps_label/fps"
onready var nav_2d = $"Navigation2D"
onready var nav_2d2 = $"Navigation2D2"
onready var nav_2d3 = $"Navigation2D3"
onready var prota = $"body/prota"
onready var pressed = true
onready var time_again = 0

func _ready():
	Global.HP = 100
	$"body/environment".play()
	$"exit_sign1/Light2D/AnimationPlayer".play("light_blink")
	$"exit_sign2/Light2D/AnimationPlayer".play("light_blink")
	$"Light2D/AnimationPlayer".play("light_blink")
	$"Light2D2/AnimationPlayer".play("light_blink")
	$"Light2D3/AnimationPlayer".play("light_blink")
	if Global.cpad:
		$"body/controls/dpad".visible = false
		$"body/controls/circlepad".visible = true
	else:
		$"body/controls/dpad".visible = true
		$"body/controls/circlepad".visible = false

func _process(delta):
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	$"body/HP_rapid".value = Global.HP
	var new_path = nav_2d.get_simple_path($"Navigation2D/bhost".global_position, $"Navigation2D/bhost".next_position)
	var new_path2 = nav_2d2.get_simple_path($"Navigation2D2/bhost".global_position, $"Navigation2D2/bhost".next_position)
	var new_path3 = nav_2d3.get_simple_path($"Navigation2D3/bhost".global_position, $"Navigation2D3/bhost".next_position)
	check_chasing($"Navigation2D/bhost")
	check_chasing($"Navigation2D2/bhost")
	check_chasing($"Navigation2D3/bhost")
	reduce_HP(delta, $"Navigation2D/bhost")
	reduce_HP(delta, $"Navigation2D2/bhost")
	reduce_HP(delta, $"Navigation2D3/bhost")
	$"Navigation2D/bhost".path = new_path
	$"Navigation2D2/bhost".path = new_path2
	$"Navigation2D3/bhost".path = new_path3
	change_music()
	
func change_music():
	var ghost1 = $"Navigation2D/bhost"
	var ghost2 = $"Navigation2D2/bhost"
	var ghost3 = $"Navigation2D/bhost"
	if (ghost1.next_position == ghost1.initial_position) and (ghost2.next_position == ghost2.initial_position) and (ghost3.next_position == ghost3.initial_position): 
		$"body/environment".pitch_scale = 1
	else:
		$"body/environment".pitch_scale = 1.25

func reduce_HP(delta, ghost):
	if ghost.damaging == true:
		if time_again >= 20 * delta:
			ghost.damaging = false
			Global.HP -= ghost.damage
			time_again = 0
			$"body".update_health()
		else:
			time_again += delta
	if Global.HP <= 0:
		fps.text = "Health Over :'( FPS: " + str(Engine.get_frames_per_second())
		#get_tree().change_scene("res://Scenes/menu.tscn")

func check_chasing(ghost):
	if ghost.chasing == true:
		ghost.next_position = prota.global_position
	elif ghost.chasing == false:
		ghost.next_position = ghost.initial_position
	check_distance(ghost)	

func check_distance(ghost):
	var x_diff = abs(ghost.global_position.x-prota.global_position.x)
	var y_diff = abs(ghost.global_position.y-prota.global_position.y)
	var distance_diff = sqrt(x_diff*x_diff + y_diff*y_diff)
	ghost.distance_from_prot = distance_diff
	if distance_diff >= 1000:
		ghost.next_position = ghost.initial_position
	if distance_diff < 60.0:
		ghost.damaging = true
	

func _on_back_pressed():
	$"body/environment".playing = false
	get_tree().change_scene("res://Scenes/menu.tscn")

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		$"Navigation2D/bhost".chasing = true

func _on_Area2D_body_exited(body):
	if body is KinematicBody2D:
		$"Navigation2D/bhost".chasing = false


func _on_Area2D2_body_entered(body):
	if body is KinematicBody2D:
		$"Navigation2D2/bhost".chasing = true


func _on_Area2D2_body_exited(body):
	if body is KinematicBody2D:
		$"Navigation2D2/bhost".chasing = false


func _on_Area2D3_body_entered(body):
	if body is KinematicBody2D:
		$"Navigation2D3/bhost".chasing = true


func _on_Area2D3_body_exited(body):
	if body is KinematicBody2D:
		$"Navigation2D3/bhost".chasing = false

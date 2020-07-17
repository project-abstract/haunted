extends Node2D

onready var fps = $"body/fps_label/fps"
onready var nav_2d = $"Navigation2D"
onready var nav_2d2 = $"Navigation2D2"
onready var nav_2d3 = $"Navigation2D3"
onready var prota = $"body/prota"
onready var pressed = true
onready var time_again = 0
onready var menu_path = "res://Scenes/menu.tscn"

func _ready():
	Global.hp_max = 100
	Global.HP = Global.hp_max
	$"body/HP_rapid".max_value = Global.hp_max
	$"body/HP_tween_bar".max_value = Global.hp_max
	$"body/HP_rapid".value = Global.HP
	$"body/HP_tween_bar".value = Global.HP
	$"body/prota".texture = load("res://Resources/Prot/hero_"+str(Global.prot_index)+".png")
	
	if !OS.has_touchscreen_ui_hint():
		$"body/controls/dpad/accept".visible = false 
		$"body/controls/dpad/home".visible = false
		$"body/controls/circlepad/accept".visible = false 
		$"body/controls/circlepad/home".visible = false
	
	$"body/environment".play()
	$"exit_sign1/Light2D/AnimationPlayer".play("light_blink")
	$"exit_sign2/Light2D/AnimationPlayer".play("light_blink")
	$"bulb_safe/Light2D/AnimationPlayer".play("light_blink")
	$"bulb_safe2/Light2D2/AnimationPlayer".play("light_blink")
	$"bulb_danger/Light2D3/AnimationPlayer".play("light_blink")
	
	$"health_boost/sprite1/Light2D/AnimationPlayer".play("light_blink")
	$"health_boost/sprite2/Light2D/AnimationPlayer".play("light_blink")
	$"health_boost/sprite3/Light2D/AnimationPlayer".play("light_blink")
	$"health_boost/sprite4/Light2D/AnimationPlayer".play("light_blink")
	$"health_boost/sprite5/Light2D/AnimationPlayer".play("light_blink")
	
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
	$"Navigation2D/bhost".check_prota()
	$"Navigation2D2/bhost".check_prota()
	$"Navigation2D3/bhost".check_prota()
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
	update_key()
	
func update_key():
	var red = Global.red_key
	var blue = Global.blue_key
	var green = Global.green_key
	var count = 0
	if red and !blue and !green:
		get_node("body/collected_item/key1").visible = true
		count = 1
	elif !red and blue and !green:
		get_node("body/collected_item/key2").visible = true
		count = 1
	elif !red and !blue and green:
		get_node("body/collected_item/key3").visible = true
		count = 1
	elif !red and blue and green:
		get_node("body/collected_item/key2").visible = true
		get_node("body/collected_item/key3").visible = true
		count = 2
	elif red and blue and !green:
		get_node("body/collected_item/key1").visible = true
		get_node("body/collected_item/key2").visible = true
		count = 2
	elif red and !blue and green:
		get_node("body/collected_item/key1").visible = true
		get_node("body/collected_item/key3").visible = true
		count = 2
	elif red and blue and green:
		get_node("body/collected_item/key1").visible = true
		get_node("body/collected_item/key2").visible = true
		get_node("body/collected_item/key3").visible = true
		count = 3
	else:
		 count = 0
	Global.key_counts = count

func check_if_one_is_chasing():
	if $"Navigation2D/bhost".next_position != $"Navigation2D/bhost".initial_position:
		return true
	elif $"Navigation2D2/bhost".next_position != $"Navigation2D2/bhost".initial_position:
		return true
	elif $"Navigation2D3/bhost".next_position != $"Navigation2D3/bhost".initial_position:
		return true
	else:
		return false
	
func start_distraction(location, item_time):
	if $"Navigation2D/bhost".next_position != $"Navigation2D/bhost".initial_position:
		Global.time_for_1 = item_time
		$"Navigation2D/bhost".distract_location = location
		$"Navigation2D/bhost".distracted = true
	elif $"Navigation2D2/bhost".next_position != $"Navigation2D2/bhost".initial_position:
		Global.time_for_2 = item_time
		$"Navigation2D2/bhost".distract_location = location
		$"Navigation2D2/bhost".distracted = true
	elif $"Navigation2D3/bhost".next_position != $"Navigation2D3/bhost".initial_position:
		Global.time_for_3 = item_time
		$"Navigation2D3/bhost".distract_location = location
		$"Navigation2D3/bhost".distracted = true

func change_music():
	var ghost1 = $"Navigation2D/bhost"
	var ghost2 = $"Navigation2D2/bhost"
	var ghost3 = $"Navigation2D3/bhost"
	if (ghost1.next_position != ghost1.initial_position) or (ghost2.next_position != ghost2.initial_position) or (ghost3.next_position != ghost3.initial_position): 
		$"body/environment".pitch_scale = 1.25
	else:
		$"body/environment".pitch_scale = 1

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
		dead()

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
	if distance_diff >= ghost.visibility:
		ghost.next_position = ghost.initial_position
	if distance_diff < 60.0:
		ghost.damaging = true
	

func _on_back_pressed():
	$"body/select".play()
	get_tree().paused = true
	$"body/controls".visible = false
	$"body/pause_screen/paused_text".text = "Paused"
	$"body/pause_screen".visible = true


func _on_return_button_pressed():
	$"body/select".play()
	get_tree().paused = false
	$"body/controls".visible = true
	$"body/pause_screen".visible = false


func _on_menu_button_pressed():
	$"body/select".play()
	get_tree().paused = false
	$"body/controls".visible = true
	$"body/pause_screen".visible = false
	get_tree().change_scene(menu_path)
	
func dead():
	menu_path = "res://Scenes/score_screen.tscn"
	get_tree().paused = true
	$"body/controls".visible = false
	$"body/pause_screen/return_button".visible = false
	$"body/pause_screen/paused_text".text = "Game Over"
	$"body/pause_screen/menu_button/Label".text = "Score"
	$"body/pause_screen".visible = true

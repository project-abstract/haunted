extends KinematicBody2D

onready var prota = $"prota"
onready var light = $'prota/light'
onready var ground = $"floor"
onready var hp_tween = $"hp_tween"
onready var frame_coordinates = Vector2(0, 0)
onready var previous_direction = 'd'

var frame_x = 0
var frame_y = 0
var temp = 0
var idle = true
var time_elapsed = 0
var another_time_elapsed = 0
var light_flicker = 0
var feri_time_elapsed = 0

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var speed = 300
	var velocity = Vector2(0, 0)
	idle = false
	if Global.cpad:
		var velocity_temp = $"controls/circlepad/joystick_button".get_value()*100
		if velocity_temp.x >= 9:
			frame_y = 1
			check_direction('r', delta)
			previous_direction = 'r'
			velocity = Vector2(speed*delta, 0)
		elif velocity_temp.x <= -75 and velocity_temp.y < -5:
			frame_y = 2
			check_direction('l', delta)
			previous_direction = 'l'
			velocity = Vector2(-speed*delta, 0)
		elif velocity_temp.y <= -85:
			frame_y = 3
			check_direction('u', delta)
			previous_direction = 'u'
			velocity = Vector2(0, -speed*delta)
		elif velocity_temp.y >= -5:
			frame_y = 0
			check_direction('d', delta)
			previous_direction = 'd'
			velocity = Vector2(0, speed*delta)
		else:
			velocity = Vector2(0, 0)
			frame_x = 0
			idle = true
	else:
		if Input.is_action_pressed("ui_up"):
			frame_y = 3
			check_direction('u', delta)
			previous_direction = 'u'
			velocity = Vector2(0, -speed*delta)
		elif Input.is_action_pressed("ui_down"):
			frame_y = 0
			check_direction('d', delta)
			previous_direction = 'd'
			velocity = Vector2(0, speed*delta)
		elif Input.is_action_pressed("ui_left"):
			frame_y = 2
			check_direction('l', delta)
			previous_direction = 'l'
			velocity = Vector2(-speed*delta, 0)
		elif Input.is_action_pressed("ui_right"):
			frame_y = 1
			check_direction('r', delta)
			previous_direction = 'r'
			velocity = Vector2(speed*delta, 0)
		else:
			frame_x = 0
			idle = true
	move_and_collide(velocity)
	frame_coordinates = Vector2(frame_x, frame_y)
	if idle:
		check_direction('n', delta)
	prota.frame_coords = frame_coordinates
	check_for_throw(delta)
	check_collection()

func check_for_throw(delta):
	if feri_time_elapsed >= 10* delta:
		feri_time_elapsed = 0
		if (Input.is_key_pressed(KEY_C) or Input.is_action_pressed("ui_home")) and Global.items_collected.size() > 0 and get_parent().check_if_one_is_chasing():
			var thrown_item = get_parent().get_node(Global.realname(Global.items_collected[0])+"/"+Global.realname(Global.items_collected[0]))
			thrown_item.get_parent().position = self.position
			thrown_item.visible = true
			Global.throw_item()
			get_parent().start_distraction(thrown_item.global_position, thrown_item.distraction_time)
	else:
		feri_time_elapsed += delta

func check_collection():
	get_node("collected_item/Sprite1").visible = false
	get_node("collected_item/Sprite2").visible = false
	get_node("collected_item/Sprite3").visible = false
	get_node("collected_item/Sprite4").visible = false
	get_node("collected_item/Sprite5").visible = false
	var show_no = Global.items_collected.size()
	for i in range(show_no):
		get_node("collected_item/Sprite"+str(i+1)).texture = load(Global.getname(Global.items_collected[i]))
		get_node("collected_item/Sprite"+str(i+1)).visible = true

func check_direction(dir, delta):
	if another_time_elapsed >= 10 * delta:
		another_time_elapsed = 0
		if dir != 'n':
			temp += 1
			if previous_direction == dir:
				temp += 5
			else:
				temp = 0
				previous_direction = dir
			if temp > 19:
				temp = 0
			frame_x = temp
		else:
			temp += 1
			if temp > 4:
				temp = 0
			frame_coordinates = Vector2(temp, frame_y)
		if light_flicker:
			$"prota/light".energy = 50*delta
		else:
			$"prota/light".energy = 60*delta
	else:
		another_time_elapsed += delta

func update_health():
	var health_bar = $"HP_tween_bar"
	hp_tween.interpolate_property(health_bar, "value", health_bar.value, Global.HP, 1, Tween.TRANS_SINE, Tween.EASE_IN)
	hp_tween.start()

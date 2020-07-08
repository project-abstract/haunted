extends KinematicBody2D

onready var prota = $"prota"
onready var light = $'prota/light'
onready var ground = $"floor"
onready var frame_coordinates = Vector2(0, 0)
onready var previous_direction = 'd'

var frame_x = 0
var frame_y = 0
var temp = 0
var time_elapsed = 0

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var speed = 300
	var velocity = Vector2(0, 0)
	if time_elapsed >= speed/600*delta:
		time_elapsed = 0
		if get_parent().circlepad:
			var velocity_temp = $"controls/circlepad/joystick_button".get_value()*100
			if velocity_temp.x >= 45:
				frame_y = 2
				check_direction('r')
				previous_direction = 'r'
				velocity = Vector2(speed*delta, 0)
			elif velocity_temp.x <= -80:
				frame_y = 1
				check_direction('l')
				previous_direction = 'l'
				velocity = Vector2(-speed*delta, 0)
			elif velocity_temp.y <= -85:
				frame_y = 3
				check_direction('u')
				previous_direction = 'u'
				velocity = Vector2(0, -speed*delta)
			elif velocity_temp.y >= 40:
				frame_y = 0
				check_direction('d')
				previous_direction = 'd'
				velocity = Vector2(0, speed*delta)
			else:
				velocity = Vector2(0, 0)
		else:
			if Input.is_action_pressed("ui_up"):
				frame_y = 3
				check_direction('u')
				previous_direction = 'u'
				velocity = Vector2(0, -speed*delta)
				
			elif Input.is_action_pressed("ui_down"):
				frame_y = 0
				check_direction('d')
				previous_direction = 'd'
				velocity = Vector2(0, speed*delta)
				
			elif Input.is_action_pressed("ui_left"):
				frame_y = 1
				check_direction('l')
				previous_direction = 'l'
				velocity = Vector2(-speed*delta, 0)
				
			elif Input.is_action_pressed("ui_right"):
				frame_y = 2
				check_direction('r')
				previous_direction = 'r'
				velocity = Vector2(speed*delta, 0)
				
			else:
				frame_x = 0
		move_and_collide(velocity)
		frame_coordinates = Vector2(frame_x, frame_y)
		prota.frame_coords = frame_coordinates
	else:
		time_elapsed += delta

func check_direction(dir):
	if previous_direction == dir:
		temp += 1
	else:
		frame_x = 0
		previous_direction = dir
	if temp > 3:
		temp = 0
	frame_x = temp

extends Node2D

var speed = 200.0
var damage = 15
var visibility = 800
var distracted = false

var path : = PoolVector2Array() setget set_path
var time_d = 0
var frame_coords = 0
export var chasing = false
var next_position = Vector2(0,0)
var distance_from_prot = 0
var damaging = false
var initial_position = Vector2(496, -112)
var distract_location = Vector2(0, 0)
var time_distracted = 0

func _ready():
	set_process(false)

func _process(delta):
	var move_distance = speed * delta
	move_along_path(move_distance)
	animate_villian(delta)
	be_distracted(delta)
	
func check_prota():
	var collisions = str(get_parent().get_parent().get_node("Area2D").get_overlapping_bodies())
	if "KinematicBody2D" in collisions:
		chasing = true
	else:
		chasing = false
	
func be_distracted(delta):
	if distracted == true:
		chasing = false
		next_position = distract_location
		time_distracted += delta
	if time_distracted >= Global.time_for_1:
		distracted = false
		time_distracted = 0

func move_along_path(distance: float):
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0 and distance_to_next != 0.0:
			position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)	

func set_path(value: PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)

func animate_villian(delta):
	if time_d > 4 * delta:
		time_d = 0
		frame_coords += 1
		if frame_coords > 7:
			frame_coords = 0
		$"villian".frame_coords.x = frame_coords
		if chasing:
			$"villian".frame_coords.y = 1
		else:
			$"villian".frame_coords.y = 0
	else:
		time_d += delta

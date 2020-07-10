extends TouchScreenButton

var initial_pos = Vector2(152, 450)
var radius = Vector2(25, 25)
var boundary = 64
var drag_active = -1
var threshold = 10

func get_button_pos():
	return self.position+radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var distance_from_center = (initial_pos - event.position).length()
		if distance_from_center <= boundary*global_scale.x or event.get_index() == drag_active:
			self.position = event.position - radius * global_scale
			if (get_button_pos() - initial_pos).length() > boundary:
				self.position = initial_pos + Vector2(-boundary, -boundary) + boundary*(event.position - initial_pos).normalized()
			drag_active = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == drag_active:
		self.position = initial_pos + Vector2(-boundary, -boundary)
		drag_active = -1

func get_value():
	return (get_button_pos()-initial_pos).normalized()
	if (get_button_pos()-initial_pos).length() >= threshold:
		return (get_button_pos()-initial_pos).normalized()
	else:
		return Vector2(0, 0)

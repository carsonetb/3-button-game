class_name Util 

static func pick_rect_point(rect: Rect2) -> Vector2:
	return Vector2(
		randf_range(rect.position.x, rect.position.x + rect.size.x),
		randf_range(rect.position.y, rect.position.y + rect.size.y)
	)

static func control_to_rect(control: Control) -> Rect2:
	return Rect2(control.position, control.size)

static func pick_control_point(control: Control) -> Vector2:
	return pick_rect_point(control_to_rect(control))

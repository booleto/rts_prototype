extends Camera2D
class_name PlayerCamera

var max_zoom : float = 2
var min_zoom : float = 0.3

func adjust_zoom(unit : float):
	var next_zoom = zoom + Vector2(unit, unit)
	zoom = next_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	
func reset_zoom(unit : Vector2 = Vector2.ONE):
	zoom = unit

func move(velocity : Vector2):
	translate(velocity)

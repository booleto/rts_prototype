extends Node2D
class_name RectIntersectQuery

var select_rect : RectangleShape2D

func _ready():
	select_rect = RectangleShape2D.new()

func query(start : Vector2, end : Vector2, mask : int):
	print("start: ", start, " end: ", end)
	select_rect.extents = abs(end - start) / 2
	var space = get_world_2d().direct_space_state
	var q = PhysicsShapeQueryParameters2D.new()
	q.shape = select_rect
	q.collision_mask = 2
	q.transform = Transform2D(0, (end + start) / 2)
	return space.intersect_shape(q)

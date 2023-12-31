extends Node2D
class_name RectIntersectQuery

var select_rect : RectangleShape2D

func _ready():
	select_rect = RectangleShape2D.new()

func query(start : Vector2, end : Vector2, mask : int):
	select_rect.extents = abs(end - start) / 2
	var space = get_world_2d().direct_space_state
	var q = PhysicsShapeQueryParameters2D.new()
	q.shape = select_rect
	q.collision_mask = mask
	q.transform = Transform2D(0, (end + start) / 2)
	return space.intersect_shape(q)

func single_query(start : Vector2, end : Vector2, mask : int):
	print("single query")
	var space = get_world_2d().direct_space_state
	var q = PhysicsPointQueryParameters2D.new()
	q.collision_mask = mask
	q.position = end
	return space.intersect_point(q, 1)

extends Node2D
class_name RectIntersectQuery

var select_rect : RectangleShape2D
var tree_signal : Signal

func _ready():
	select_rect = RectangleShape2D.new()
	tree_signal = get_tree().physics_frame

func query(start : Vector2, end : Vector2, mask : int):
	await(tree_signal)
	select_rect.extents = abs(end - start) / 2
	var space = get_world_2d().direct_space_state
	var q = PhysicsShapeQueryParameters2D.new()
	q.shape = select_rect
	q.collision_mask = mask
	q.transform = Transform2D(0, (end + start) / 2)
	return space.intersect_shape(q)

func single_query(start : Vector2, end : Vector2, mask : int):
	await(tree_signal)
	var space = get_world_2d().direct_space_state
	var q = PhysicsPointQueryParameters2D.new()
	q.collision_mask = mask
	q.position = end
	return space.intersect_point(q, 1)

extends Node2D
class_name PlayerControl

@onready var camera : Camera2D = $Camera2D
@onready var unit_select : UnitSelect = $UnitSelect
@onready var rect_intersect : RectIntersectQuery = $RectIntersectQuery

var zoom_unit : float = 0.1
var default_zoom : float = 0.7
var cam_movement_scale : float = 0.2
var mouse1_held : bool = false
var mouse2_held : bool = false

var _prev_mouse_position : Vector2
var dragging = false  # are we currently dragging?
var drag_start = Vector2.ZERO  # location where the drag begian

#region Main
# Called when the node enters the scene tree for the first time.
func _ready():
	camera.reset_zoom(Vector2.ONE * default_zoom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	control_zoom(event)
	update_mouse(event)
	update_camera_movement(event)
	update_unit_selection(event)
#endregion

#region Camera zoom
func control_zoom(event):
	if not(event is InputEventMouseButton and event.pressed == true):
		return
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		zoom_camera(zoom_unit)
	if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		zoom_camera(-zoom_unit)

func zoom_camera(unit):
	camera.adjust_zoom(unit)	

func set_zoom(unit):
	camera.reset_zoom(unit)
#endregion


#region Update mouse buttons
func update_mouse(event):
	if not event is InputEventMouseButton:
		return
		
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse1_held = true
		else:
			mouse1_held = false
		return
		
	if event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			mouse2_held = true
		else:
			mouse2_held = false
		return
#endregion


#region Camera Movement
func update_camera_movement(event):
	if not event is InputEventMouseMotion:
		return
	if mouse2_held:
		camera.translate( -(get_viewport().get_mouse_position() - _prev_mouse_position))
	_prev_mouse_position = get_viewport().get_mouse_position()
#endregion


#region Unit Selection

func update_unit_selection(event):
	if mouse2_held:
		unit_select.clear_selection()
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# If the mouse was clicked and nothing is selected, start dragging
			if unit_select.get_size() == 0:
				print("sel")
				dragging = true
				drag_start = get_global_mouse_position()
			# Otherwise a click tells the selected units to move
			else:
				unit_select.set_target(get_global_mouse_position())
		# If the mouse is released and is dragging, stop dragging and select the units
		elif dragging:
			dragging = false
			var drag_end = get_local_mouse_position()
			var query_result = rect_intersect.query(drag_start, drag_end, 2)
			query_result = query_result.map(func(entry): return entry.collider)
			unit_select.add_to_selection(query_result)
			queue_redraw()
	if event is InputEventMouseMotion and dragging:
		queue_redraw()
		
func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
				Color.YELLOW, false, camera.zoom.x * 20)

#endregion

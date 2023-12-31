extends Node2D
class_name PlayerControl

@onready var camera : Camera2D = $Camera2D
@onready var unit_select : UnitSelect = $UnitSelect
@onready var building_select : BuildingSelect = $BuildingSelect
@onready var rect_intersect : RectIntersectQuery = $RectIntersectQuery

var zoom_unit : float = 0.1
var default_zoom : float = 0.7
var camera_move_speed : float = 1000
var mouse_drag_deadzone : float = 90

#region Input parameters
var mouse1_held : bool = false
var mouse2_held : bool = false
var shift_held : bool = false

var single_select : bool = false
var drag_select : bool = false
var deselect : bool = false

var move_up : bool = false
var move_down : bool = false
var move_left : bool = false
var move_right : bool = false

#endregion
var _prev_mouse_position : Vector2
var dragging = false  # are we currently dragging?
var mouse1_start = Vector2.ZERO  # location where the drag begian

#region Main
# Called when the node enters the scene tree for the first time.
func _ready():
	camera.reset_zoom(Vector2.ONE * default_zoom)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_input_parameters()
	update_camera_move(delta)
	update_unit_selection()
	pass
	
func _unhandled_input(event):
	control_zoom(event)
	update_camera_drag(event)
	
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


#region Update inputs
#func update_mouse(event):
	#if not event is InputEventMouseButton:
		#return
		#
	#if event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#mouse1_held = true
		#else:
			#mouse1_held = false
		#return
		#
	#if event.button_index == MOUSE_BUTTON_RIGHT:
		#if event.pressed:
			#mouse2_held = true
		#else:
			#mouse2_held = false
		#return

func update_input_parameters():
	mouse1_held = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	mouse2_held = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	shift_held = Input.is_action_pressed("shift")
#endregion


#region Camera Movement
func update_camera_drag(event):
	if not event is InputEventMouseMotion:
		return
	if mouse2_held:
		camera.translate( -(get_viewport().get_mouse_position() - _prev_mouse_position))
	_prev_mouse_position = get_viewport().get_mouse_position()
	
func update_camera_move(delta : float):
	var movement_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if shift_held:
		movement_vec *= 2
	camera.move(movement_vec * delta * camera_move_speed)
#endregion


#region Unit Selection

func update_unit_selection():
	#if mouse2_held:
		#unit_select.clear_selection()
		#return
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			## If the mouse was clicked and nothing is selected, start dragging
			#if unit_select.get_size() == 0:
				#print("sel")
				#dragging = true
				#drag_start = get_global_mouse_position()
			## Otherwise a click tells the selected units to move
			#else:
				#unit_select.set_target(get_global_mouse_position())
		## If the mouse is released and is dragging, stop dragging and select the units
		#elif dragging:
			#dragging = false
			#var drag_end = get_local_mouse_position()
			#var query_result = rect_intersect.query(drag_start, drag_end, 2)
			#query_result = query_result.map(func(entry): return entry.collider)
			#unit_select.add_to_selection(query_result)
			#queue_redraw()
	#if event is InputEventMouseMotion and dragging:
		#queue_redraw()

	if mouse2_held and not shift_held:
		unit_select.clear_selection()
		return
	if mouse1_held and not dragging:
		# start selection
		if unit_select.get_size() == 0:
			mouse1_start = get_global_mouse_position()
			dragging = true
			queue_redraw()
		elif not shift_held:
			# order movement
			unit_select.set_target(get_global_mouse_position())

	if dragging and not mouse1_held:
		# finalize select
		if not shift_held:
			print("clear selection")
			unit_select.clear_selection()
			building_select.clear_selection()
		#selection
		var drag_end = get_local_mouse_position()
		if (mouse1_start - drag_end).length() < mouse_drag_deadzone:
			#single select
			var query_result = rect_intersect.single_query(mouse1_start, drag_end, 2)
			if query_result.size() != 0:
				query_result = query_result.map(func(entry): return entry.collider)
				if query_result[0] is Unit:
					print("added to selection")
					unit_select.add_to_selection(query_result)
				#TODO: if query is Building
			dragging = false

		else:
			#multiselect
			var query_result = rect_intersect.query(mouse1_start, drag_end, 2)
			query_result = query_result.map(func(entry): return entry.collider)
			unit_select.add_to_selection(query_result)
			queue_redraw()
			dragging = false

	if dragging:
		queue_redraw()
		
func _draw():
	if dragging:
		draw_rect(Rect2(mouse1_start, get_global_mouse_position() - mouse1_start),
				Color.YELLOW, false, camera.zoom.x + 10)

#endregion

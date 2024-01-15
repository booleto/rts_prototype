extends State
class_name StatePlayerIdle

var unit_select : UnitSelect

func initialize():
	super()
	await actor.ready
	unit_select = actor.unit_select

func enter(params : Dictionary):
	super(params)
	actor.queue_redraw()

func update(_delta):
	super(_delta)
	if Input.is_action_just_pressed("leftclick"):
		var params = {
			"mouse1_start" : actor.get_global_mouse_position()
		}
		state_machine.transition_to("StateSelecting", params)
		
	if Input.is_action_just_pressed("build"):
		state_machine.transition_to("StateBuilding", {})
	
func physics_update(_delta):
	super(_delta)
	
func exit():
	super()


func input_update(event):
	update_squad_select(event)
	update_camera_drag(event)
	
func update_squad_select(event):
	if not(event is InputEventKey and event.pressed):
		return
	
	var squad_index = actor.keycode_to_index(event.keycode)
			
	if squad_index == null or not unit_select.has_squad(squad_index): return
	unit_select.select_squad(squad_index)
	state_machine.transition_to("StateCommanding", {})

var _prev_mouse_position
func update_camera_drag(event):
	if not event is InputEventMouseMotion:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		actor.camera.translate( -(actor.get_viewport().get_mouse_position() - _prev_mouse_position))
	_prev_mouse_position = get_viewport().get_mouse_position()

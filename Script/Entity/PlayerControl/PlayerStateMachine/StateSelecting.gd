extends State
class_name StateSelecting

var faction : int
var mouse1_start : Vector2
var mouse_drag_deadzone : float = 90
var intersect_query : RectIntersectQuery

func initialize():
	assert(actor is PlayerControl, "PLayer control state assigned to non-player")
	await actor.ready
	intersect_query = actor.rect_intersect

func enter(params : Dictionary):
	super(params)
	mouse1_start = params.get("mouse1_start", Vector2.ZERO)
	actor.mouse1_start = mouse1_start

func update(_delta):
	actor.queue_redraw()
	if Input.is_action_just_released("leftclick"):
		var mouse1_end = actor.get_global_mouse_position()
		var selected
		if (mouse1_end - mouse1_start).length() <= mouse_drag_deadzone:
			selected = await intersect_query.single_query(mouse1_start, mouse1_end, 2)
		else:
			selected = await intersect_query.query(mouse1_start, mouse1_end, 2)
		finalize_selection(selected)
	
func physics_update(_delta):
	pass
	
func exit():
	super()

func finalize_selection(selected : Array):
	selected = selected.map(func(entry): return entry.collider)
	selected = selected.filter(func(entry): return (entry is Unit) and (entry.faction == actor.faction))
	if selected.size() == 0:
		state_machine.transition_to("StatePlayerIdle", {})
		return
	if selected.size() == 1:
		if selected[0] is Unit:
			actor.unit_select.add_to_selection(selected)
			state_machine.transition_to("StateCommanding", {})
			return
		
	actor.unit_select.add_to_selection(selected)
	state_machine.transition_to("StateCommanding", {})

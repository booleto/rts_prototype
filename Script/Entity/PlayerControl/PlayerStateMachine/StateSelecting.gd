extends State
class_name StateSelecting

var drag_start : Vector2
var mouse_drag_deadzone : float = 90

func initialize():
	assert(actor is PlayerControl, "PLayer control state assigned to non-player")

func enter(params : Dictionary):
	super(params)

func update(_delta):
	if actor.mouse2_held and not actor.shift_held:
		actor.unit_select.clear_selection()
		state_machine.transition_to("StateIdle", {})
	if actor.dragging and not actor.mouse1_held:
		pass
	
func physics_update(_delta):
	pass
	
func exit():
	super()

func queue_draw():
	actor.queue_draw()

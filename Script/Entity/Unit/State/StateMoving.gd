extends State
class_name StateMoving

var nav : NavComponent

func initialize():
	super()
	await(actor.ready)
	nav = actor.nav_component

func enter(params : Dictionary):
	super(params)
	
func update(_delta):
	super(_delta)
	
func physics_update(_delta):
	super(_delta)
	if !nav.is_moving:
		state_machine.transition_to("StateIdle", {})
	var velocity = (nav.next_path() - actor.global_position).normalized()
	velocity *= actor.move_speed
	actor.velocity = velocity
	actor.move_and_slide()
	
func exit():
	super()

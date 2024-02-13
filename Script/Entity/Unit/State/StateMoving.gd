extends State
class_name StateMoving

var nav : NavComponent
var previous_pos : Vector2

func initialize():
	super()
	await(actor.ready)
	nav = actor.nav_component
	previous_pos = actor.position

func enter(params : Dictionary):
	super(params)
	
func update(_delta):
	super(_delta)

func physics_update(_delta):
	super(_delta)
	if !nav.is_moving:
		state_machine.transition_to("StateIdle", {})
	var target_vec : Vector2 = nav.next_path() - actor.global_position
	var velocity : Vector2 = target_vec.normalized()
	velocity *= actor.move_speed
	#print_debug("velocity: ", velocity.length(), " target_vec: ", target_vec.length())
	actor.velocity = target_vec if (velocity.length() >= target_vec.length()) else velocity
	if actor.velocity == Vector2.ZERO:
		nav.cancel_movement()
		state_machine.transition_to("StateIdle", {})
	actor.position += actor.velocity
	
func exit():
	#print_debug("Stopped moving")
	super()

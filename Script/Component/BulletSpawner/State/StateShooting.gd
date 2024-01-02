extends State
class_name StateShooting

var tick : int = 0
var position : Vector2
var angle : float
var duration : int

func initialize():
	super()

func enter(params : Dictionary):
	super(params)
	tick = 0
	position = params.get('position', actor.position)
	angle = params.get('angle', 0)
	duration = params.get('duration', 100)

func update(_delta):
	super(_delta)
	
func physics_update(_delta):
	super(_delta)
	var status = state_machine.bullet_pattern.update(tick, position, angle)
	tick += 1
	if status == state_machine.bullet_pattern.status.ENDED or tick >= duration:
		state_machine.transition_to("StateCooldown", {})
	
#func exit():
	#super()

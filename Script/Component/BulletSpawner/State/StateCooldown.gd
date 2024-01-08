extends State
class_name StateCooldown

var cooldown : Timer

func initialize():
	super()
	cooldown = Timer.new()
	cooldown.wait_time = state_machine.shot_cooldown
	cooldown.one_shot = true
	cooldown.timeout.connect(_on_cooldown_ended)
	add_child(cooldown)

func enter(params : Dictionary):
	super(params)
	cooldown.wait_time = actor.shot_cooldown
	cooldown.start()

#func update(_delta):
	#super(_delta)
	#
#func physics_update(_delta):
	#super(_delta)
	#
#func exit():
	#super()

func _on_cooldown_ended():
	state_machine.transition_to("StateIdle", {})

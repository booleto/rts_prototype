extends Node
class_name StateMachine

signal state_changed

var current_state : State
@export var initial_state : State

# Called when the node enters the scene tree for the first time.
func _ready():
	for state in get_children():
		assert(state is State, "Non-state is child of state machine")
		state.actor = get_parent()
		state.state_machine = self
		state.initialize()
	current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_state.update(delta)
	
func _physics_process(delta):
	current_state.physics_update(delta)

func transition_to(state_name : String, params : Dictionary):
	var next_state = get_node(state_name)
	assert(next_state != null, "Cannot find requested state")
	current_state.exit()
	current_state = get_node(state_name)
	current_state.enter(params)
	emit_signal("state_changed")

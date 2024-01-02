extends StateMachine
class_name BulletSpawner

@export var bullet_pattern : BulletPattern
var shot_cooldown : float = 0.5
var shot_duration : float

func transition_to(state_name : String, params : Dictionary):
	if current_state.name == "StateCooldown" and state_name != "StateIdle":
		return
	var next_state = get_node(state_name)
	assert(next_state != null, "Cannot find requested state")
	current_state.exit()
	current_state = get_node(state_name)
	current_state.enter(params)
	emit_signal("state_changed")

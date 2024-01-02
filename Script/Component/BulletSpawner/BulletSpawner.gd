extends StateMachine
class_name BulletSpawner

@export var bullet_pattern : BulletPattern
var shot_cooldown : float = 1.5
var shot_duration : float

#var cooldown : Timer
#var is_cooldown : bool = false
#var is_shooting : bool = false
#var tick : int = 0
#
#func _ready():
	#cooldown = Timer.new()
	#cooldown.wait_time = shot_cooldown
	#cooldown.one_shot = true
	#cooldown.timeout.connect(_on_cooldown_ended)
	#pass 
	#
#func _physics_process(delta):
	#if is_shooting:
#
#func start_shooting(angle : float):
	#bullet_pattern.update()
#
#func start_cooldown():
	#tick = 0
	#is_shooting = false
	#is_cooldown = true
	#cooldown.start()
#
#func shoot(angle : float):
	#bullet_pattern.shot_angle = angle
	#bullet_pattern
	#
#func change_pattern(pattern : BulletPattern):
	#bullet_pattern = pattern
#
#func _on_cooldown_ended():
	#is_cooldown = false

func transition_to(state_name : String, params : Dictionary):
	var next_state = get_node(state_name)
	assert(next_state != null, "Cannot find requested state")
	if next_state == current_state:
		return
	current_state.exit()
	current_state = get_node(state_name)
	current_state.enter(params)
	emit_signal("state_changed")

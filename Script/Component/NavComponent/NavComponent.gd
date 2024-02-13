extends Node2D
class_name NavComponent

signal path_finished

@export var move_speed : float = 100
var is_moving : bool = false
var target : Vector2
var actor : Unit

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D

func _ready():
	nav_agent.max_speed = move_speed
	#nav_agent.target_desired_distance = move_speed / 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#if !is_moving: return
	#var velocity = (nav_agent.get_next_path_position() - actor.global_position).normalized()
	#velocity *= move_speed
	#actor.velocity = velocity


func set_target(vec : Vector2):
	if actor == null:
		actor = get_parent()
	nav_agent.target_position = vec
	is_moving = true

func next_path():
	return nav_agent.get_next_path_position()
	
func set_move_speed(speed : float):
	move_speed = speed
	nav_agent.max_speed = move_speed
	#nav_agent.target_desired_distance = move_speed / 5
	
func cancel_movement():
	is_moving = false
	nav_agent.target_position = actor.position

func _on_navigation_agent_2d_target_reached():
	cancel_movement()

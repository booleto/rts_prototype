extends Node
class_name BulletPattern

signal pattern_ended

var bullet_prefab : Resource
var physics_tick : int
var shot_angle : float
var casting : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	physics_tick += 1

func stop():
	physics_tick = 0
	casting = false
	emit_signal("pattern_ended")

func start():
	casting = true

extends Node
class_name BulletPattern

var bullet_prefab : Resource
var physics_tick : int
var shot_angle : float
var pattern : MovementPattern
var casting : bool = false
var cast_phase : int = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	physics_tick += 1
	if not casting:
		return
	if physics_tick >= cast_phase:
		physics_tick = 0

extends Node
class_name BulletSpawner

@export var bullet_pattern : BulletPattern
var shot_cooldown : float = 1.5
var shot_duration : float = 1
var cooldown : Timer
var in_cooldown : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown = Timer.new()
	cooldown.wait_time = shot_cooldown
	cooldown.one_shot = true
	cooldown.timeout.connect(_on_cooldown_ended)
	pass # Replace with function body.

func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot(angle : float):
	bullet_pattern.shot_angle = angle
	bullet_pattern.start()
	
func _on_cooldown_ended():
	pass

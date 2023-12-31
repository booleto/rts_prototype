extends CharacterBody2D
class_name Bullet

@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer

@export var movement_pattern : MovementPattern
@export var bullet_health : float = 1

var bullet_dmg : float = 100
var bullet_lifetime : float = 5
var bullet_max_dist : float
var bullet_speed : float = 500
var bullet_time : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bullet_time = bullet_lifetime - timer.time_left
	velocity = movement_pattern.next_velocity(rotation, position, bullet_speed, bullet_time, delta)
	rotation = movement_pattern.next_rotation(rotation, position, bullet_speed, bullet_time, delta)
	#print(velocity)
	var collision = move_and_collide(velocity)
	handle_collision(collision)

func _on_timer_timeout():
	queue_free()

func take_damage(dmg: float):
	bullet_health -= dmg
	print(name, " took dmg, health: ", bullet_health)
	if bullet_health <= 0:
		queue_free()


func handle_collision(collision):
	if collision == null:
		return
	var body = collision.get_collider()
	if body is Bullet:
		#simultaneous bullet collision - prevent 1-sided freeing
		var body_health = body.bullet_health
		body.bullet_health -= bullet_health
		bullet_health -= body_health
		body.take_damage(0)
		take_damage(0)

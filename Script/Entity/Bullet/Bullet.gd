extends Area2D
class_name Bullet

@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer

@export var movement_pattern : MovementPattern
@export var bullet_health : float = 1

static var bullet_count = 0

var faction : int = 1
var bullet_dmg : float = 100
var bullet_lifetime : float = 10
var bullet_max_dist : float
var bullet_speed : float = 500
var bullet_time : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_count += 1
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = bullet_lifetime
	timer.start()
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bullet_time = bullet_lifetime - timer.time_left
	var velocity = movement_pattern.next_velocity(rotation, position, bullet_speed, bullet_time, delta)
	rotation = movement_pattern.next_rotation(rotation, position, bullet_speed, bullet_time, delta)
	#print(velocity)
	#var collision = move_and_collide(velocity)
	#handle_collision(collision)
	position += velocity

func _on_timer_timeout():
	free_bullet()

func take_damage(dmg: float):
	bullet_health -= dmg
	#print(name, " took dmg, health: ", bullet_health)
	if bullet_health <= 0:
		free_bullet()

func set_collision_radius(radius : float):
	collision_shape.shape.radius = radius

func _on_area_entered(collision):
	if collision == null:
		return
	var body = collision#.get_collider()
	#print(self.faction, body.faction)
	
	if (body is Hurtbox) and (FactionUtils.is_hostile(faction, body.faction)):
		take_damage(body.penetration_resistance)
		body.take_damage(bullet_dmg)
	if (body is Bullet) and (FactionUtils.is_hostile(faction, body.faction)):
		#simultaneous bullet collision - prevent 1-sided freeing
		var body_health = body.bullet_health
		body.bullet_health -= bullet_health
		bullet_health -= body_health
		body.take_damage(0)
		take_damage(0)



func _on_body_entered(body):
	if body is TileMap:
		free_bullet()
	
	if body is Building:
		if FactionUtils.is_hostile(faction, body.faction):
			body.take_damage(bullet_dmg)
			take_damage(body.penetration_resistance)
		else:
			take_damage(body.penetration_resistance)
			
func free_bullet():
	bullet_count -= 1
	queue_free()

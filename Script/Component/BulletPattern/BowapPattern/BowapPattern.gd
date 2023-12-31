extends BulletPattern
class_name BowapPattern

var bullet_temp
var pattern : MovementPattern

func _ready():
	pattern = LinearMovement.new()
	bullet_prefab = preload("res://Scene/Bullet/bullet.tscn")
	
func _physics_process(delta):
	super(delta)
	if not casting:
		return
	if fmod(physics_tick, 1) <= 1:
		bullet_temp = bullet_prefab.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.rotation = shot_angle + physics_tick
		bullet_temp.bullet_lifetime = 10
		add_child(bullet_temp)

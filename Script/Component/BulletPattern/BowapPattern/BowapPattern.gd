extends BulletPattern
class_name BowapPattern

var bullet_temp
var pattern : MovementPattern

func _ready():
	pattern = LinearMovement.new()
	bullet_prefab = preload("res://Scene/Bullet/bullet.tscn")
	
func tick(delta):
	super(delta)
	for i in range(3):
		bullet_temp = bullet_prefab.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.rotation = shot_angle + physics_tick + i * 2
		bullet_temp.bullet_lifetime = 10
		#add_child(bullet_temp)

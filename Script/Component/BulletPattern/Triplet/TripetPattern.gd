extends BulletPattern
class_name TripletPattern

var bullet_temp

func _ready():
	pattern = LinearMovement.new()
	bullet_prefab = preload("res://Scene/Bullet/bullet.tscn")
	
func _physics_process(delta):
	super(delta)
	if fmod(physics_tick, 20) <= 1:
		bullet_temp = bullet_prefab.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.rotation = shot_angle
		add_child(bullet_temp)

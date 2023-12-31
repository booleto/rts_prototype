extends BulletPattern
class_name TripletPattern

var bullet_temp
var pattern : MovementPattern

func _ready():
	pattern = LinearMovement.new()
	bullet_prefab = preload("res://Scene/Bullet/bullet.tscn")
	
func _physics_process(delta):
	super(delta)
	if not casting:
		return
	if physics_tick / 2 <= 1:
		bullet_temp = bullet_prefab.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.position += Vector2.from_angle(shot_angle + (physics_tick-1) * 90) * 100
		bullet_temp.rotation = shot_angle
		bullet_temp.bullet_lifetime = 10
		add_child(bullet_temp)
	else:
		stop()

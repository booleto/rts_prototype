extends BulletPattern
class_name BowapPattern

var bullet_scene = preload("res://Scene/Bullet/bullet.tscn")
var pattern : LinearMovement = LinearMovement.new()
	
func update(tick : int, position : Vector2, angle : float, params : Dictionary = {}) -> status:
	for i in range(3):
		var bullet_temp = bullet_scene.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.rotation = angle + tick + i * 2
		bullet_temp.bullet_lifetime = 10
		EntityManager.spawn_dmk(bullet_temp)
	return status.ONGOING

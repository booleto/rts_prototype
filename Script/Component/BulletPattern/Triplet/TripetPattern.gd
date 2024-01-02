extends BulletPattern
class_name TripletPattern

var bullet_scene = preload("res://Scene/Bullet/bullet.tscn")
var pattern : LinearMovement = LinearMovement.new()
	
func update(tick : int, position : Vector2, angle : float, params : Dictionary = {}) -> status:
	var bullet_temp : Bullet
	for i in range(3):
		bullet_temp = bullet_scene.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.position = position
		bullet_temp.position += Vector2.from_angle(angle + (i-1) * 90) * 40
		bullet_temp.rotation = angle
		bullet_temp.bullet_lifetime = params.get("bullet_lifetime", 2)
		bullet_temp.faction = params.get("faction", 1)
		EntityManager.spawn_dmk(bullet_temp)
	return status.ENDED

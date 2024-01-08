extends BulletPattern
class_name SpreadPattern

var bullet_scene = preload("res://Scene/Bullet/BulletTypes/Orb/orb_red.tscn")
var pattern : LinearMovement = LinearMovement.new()
	
func update(tick : int, position : Vector2, angle : float, params : Dictionary = {}) -> status:
	var bullet_temp : Bullet
	for i in range(7):
		bullet_temp = bullet_scene.instantiate()
		bullet_temp.movement_pattern = pattern
		bullet_temp.position = position
		#bullet_temp.position += Vector2.from_angle(angle + (i-3) * 90) * 40
		bullet_temp.rotation = angle + (i - 4) * PI/12
		bullet_temp.bullet_lifetime = params.get("bullet_lifetime", 0.7)
		bullet_temp.faction = params.get("faction", 1)
		bullet_temp.bullet_speed = 800
		bullet_temp.bullet_health = 2
		EntityManager.spawn_dmk(bullet_temp)
	return status.ENDED

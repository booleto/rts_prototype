extends BulletPattern
class_name SniperPattern

var bullet_scene = preload("res://Scene/Bullet/BulletTypes/FireOrb/fire_red.tscn")
var pattern : LinearMovement = LinearMovement.new()
	
func update(tick : int, position : Vector2, angle : float, params : Dictionary = {}) -> status:
	var bullet_temp : Bullet
	bullet_temp = bullet_scene.instantiate()
	bullet_temp.movement_pattern = pattern
	bullet_temp.position = position
	bullet_temp.rotation = angle
	bullet_temp.bullet_lifetime = params.get("bullet_lifetime", 2)
	bullet_temp.faction = params.get("faction", 1)
	bullet_temp.bullet_time = 0.5
	bullet_temp.bullet_speed = 900
	bullet_temp.bullet_health = 3
	EntityManager.spawn_dmk(bullet_temp)
	return status.ENDED

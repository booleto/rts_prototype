extends UnitData
class_name Cacuoica

func _init():
	unit_name = "Cacuoica"
	max_health = 10
	penetration_resistance = 1
	attack_range = 10
	move_speed = 8
	hurtbox_radius = 25
	can_move_and_shoot = true
	shot_cooldown = 0.7
	texture = load("res://Asset/fesh/fesh_ride.png")
	bullet_pattern = TripletPattern.new()

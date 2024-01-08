extends UnitData
class_name Cadjtlep

func _init():
	unit_name = "Cadjtlep"
	max_health = 50
	penetration_resistance = 1
	attack_range = 10
	move_speed = 220
	hurtbox_radius = 25
	can_move_and_shoot = false
	shot_cooldown = 2
	texture = load("res://Asset/fesh/fesh_djtlep.png")
	bullet_pattern = SniperPattern.new()

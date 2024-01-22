extends UnitData
class_name Cadjtbu

func _init():
	unit_name = "Cadjtbu"
	max_health = 10
	penetration_resistance = 1
	attack_range = 10
	move_speed = 200
	hurtbox_radius = 25
	can_move_and_shoot = false
	shot_cooldown = 0.5
	texture = load("res://Asset/fesh/fesh_djtbu.png")
	bullet_pattern = SpreadPattern.new()
	description = tr("")

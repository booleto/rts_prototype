extends Resource
class_name UnitData

#region Basic Unit Stats
var unit_name : String
var max_health : float
var penetration_resistance : float
var attack_range : float
var move_speed : float
var hurtbox_radius : float
var shot_cooldown : float
var can_move_and_shoot : bool
#endregion

var texture : Texture2D
var bullet_pattern : BulletPattern

var description : String

func _init():
	printerr("Contructor of UnitData must be overridden. All inherited fields must be initialized")
#
#func load_unit(unit : Unit) -> Unit:
	#unit.name = unit_name
	#unit.max_health = max_health
	#unit.penetration_resistance = penetration_resistance
	#unit.attack_range = attack_range
	#unit.move_speed = move_speed
	#unit.hurtbox_radius = hurtbox_radius
	#unit.sprite.texture
	#return unit

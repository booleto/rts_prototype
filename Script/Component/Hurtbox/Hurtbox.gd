extends Area2D
class_name Hurtbox

signal took_damage(dmg : float)

@onready var hurtbox_shape : CollisionShape2D = $HurtboxShape
var actor
var penetration_resistance
var faction

func _ready():
	actor = get_parent()
	
func take_damage(dmg : float):
	actor.take_damage(dmg)
	print("damaged")
	emit_signal("took_damage", dmg)

func set_radius(r : float):
	assert(hurtbox_shape.shape is CircleShape2D, "Setting hurtbox radius on non-circle hurtbox")
	hurtbox_shape.shape.radius = r


func _on_body_entered(body):
	if body is Bullet:
		#take_damage(body.bullet_dmg)
		#body.take_damage(penetration_resistance)
		return

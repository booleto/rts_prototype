extends ProgressBar
class_name HealthComponent

signal took_damage(dmg : float)
signal took_healing(heal : float)
signal health_depleted

var actor
var health : float
var max_health : float

func _ready():
	actor = get_parent()
	await(actor.ready)
	visible = false
	health = actor.max_health
	max_health = actor.max_health

func take_damage(dmg : float):
	health -= dmg
	took_damage.emit(dmg)
	if health <= 0:
		health_depleted.emit()
		actor.queue_free()

func take_healing(heal : float):
	health += heal
	clamp(health, 0, max_health)
	took_healing.emit(heal)
	
func update_health_visual():
	value = health
	max_value = max_health

func show_healthbar():
	update_health_visual()
	visible = true

func hide_healthbar():
	visible = false

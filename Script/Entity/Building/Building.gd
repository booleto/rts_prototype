extends StaticBody2D
class_name Building

@onready var health_component = $HealthComponent

var max_health : float = 500
var penetration_resistance : int = 100
var production : int = 10
var faction : int = 0

func take_damage(dmg : float):
	health_component.take_damage(dmg)

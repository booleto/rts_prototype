extends StaticBody2D
class_name Building

signal money_produced(money : int)
signal damaged(dmg : float)
signal destroyed

@onready var health_component = $HealthComponent
@onready var eco_generator = $EcoGenerator

var max_health : float = 500
var penetration_resistance : int = 100
var production_rate : int = 10
var faction : int

func _ready():
	eco_generator.actor = self

func take_damage(dmg : float):
	damaged.emit(dmg)
	health_component.take_damage(dmg)


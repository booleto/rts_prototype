extends Node
class_name EcoGenerator

var actor
var timer : Timer
var production_rate : int

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	production_rate = actor.production_rate
	
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1
	timer.timeout.connect(generate_eco)
	add_child(timer)
	
func generate_eco():
	actor.money_produced.emit(production_rate)



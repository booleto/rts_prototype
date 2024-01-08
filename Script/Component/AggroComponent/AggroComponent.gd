extends Node2D
class_name AggroComponent

@onready var aggro_range : Area2D = $AggroRange
@onready var aggro_shape : CollisionShape2D = $AggroRange/CollisionShape2D

var aggro_radius : float = 50
var can_move_and_shoot : bool = false
var actor

# Called when the node enters the scene tree for the first time.
func _ready():
	actor = get_parent()
	await actor.ready
	can_move_and_shoot = actor.can_move_and_shoot
	set_aggro_radius(actor.attack_range)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_aggro_radius(radius : float):
	aggro_radius = radius
	aggro_shape.shape.radius = aggro_radius
	

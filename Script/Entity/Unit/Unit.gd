extends CharacterBody2D
class_name Unit

@onready var sprite : Sprite2D = $Sprite2D
@onready var nav_component : NavComponent = $NavComponent
@onready var state_machine : StateMachine = $UnitStateMachine
@onready var aggro_component : AggroComponent = $AggroComponent
@onready var health_component : HealthComponent = $HealthComponent
@onready var hurtbox : Hurtbox = $Hurtbox
@onready var bullet_spawner : BulletSpawner = $BulletSpawner

@export var unit_data : UnitData
@export var faction : int = 0
var unit_name : String
var max_health : float = 100
var penetration_resistance : float = 100
var attack_range : float = 100
var move_speed : float = 200
var hurtbox_radius : float = 25

var shot_cooldown : float = 1
var can_move_and_shoot : bool = true

#region main
func _ready():
	assert(unit_data != null, "Unit data not assigned to unit.")
	$Hurtbox.set_radius(hurtbox_radius)
	nav_component.set_move_speed(move_speed)
	health_component.max_health = max_health
	hurtbox.penetration_resistance = penetration_resistance
	hurtbox.faction = faction
	load_unit_data()
	init_sprite_position()
	init_dmk()

func _process(delta):
	update_sprite_direction()

#endregion

#region Load unit data
func load_unit_data():
	unit_name = unit_data.unit_name
	max_health = unit_data.max_health
	penetration_resistance = unit_data.penetration_resistance
	attack_range = unit_data.attack_range
	move_speed = unit_data.move_speed
	hurtbox_radius = unit_data.hurtbox_radius
	sprite.texture = unit_data.texture
	shot_cooldown = unit_data.shot_cooldown
	can_move_and_shoot = unit_data.can_move_and_shoot
#endregion


#region Sprite adjust and highlights
func init_sprite_position():
	var height = sprite.texture.get_height()
	sprite.offset.y = -height/2 + hurtbox_radius
	sprite.offset.x = 0

func update_sprite_direction():
	if velocity.x != 0:
		sprite.scale.x = sign(velocity.x)
	
func highlight():
	health_component.show_healthbar()

func disable_highlight():
	health_component.hide_healthbar()
#endregion


#region Nav component
func set_target(target : Vector2):
	state_machine.transition_to("StateMoving", {})
	nav_component.set_target(target)

func cancel_movement():
	nav_component.cancel_movement()
#endregion


#region Health
func take_damage(dmg : float):
	health_component.take_damage(dmg)
	
func take_healing(heal : float):
	health_component.take_healing(heal)

func set_max_health(health: float):
	health_component.max_health = health
#endregion

#TODO: implement dmk
func init_dmk():
	bullet_spawner.bullet_pattern = unit_data.bullet_pattern

func shoot_dmk(target : Vector2):
	bullet_spawner.transition_to("StateShooting", {
		'position' : position,
		'angle' : (target - position).angle(),
		'faction' : faction
	})

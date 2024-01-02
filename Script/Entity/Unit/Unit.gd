extends CharacterBody2D
class_name Unit

@onready var sprite : Sprite2D = $Sprite2D
@onready var nav_component : NavComponent = $NavComponent
@onready var state_machine : StateMachine = $UnitStateMachine
@onready var aggro_component : AggroComponent = $AggroComponent
@onready var health_component : HealthComponent = $HealthComponent
@onready var hurtbox : Hurtbox = $Hurtbox
@onready var bullet_spawner : BulletSpawner = $BulletSpawner

var unit_name : String
var max_health : float = 100
var penetration_resistance : float = 100
var attack_range : float = 100
var move_speed : float = 200
var can_move_and_shoot : bool = true
var hurtbox_radius : float = 25
var faction : int = 1

#region main
func _ready():
	$Hurtbox.set_radius(hurtbox_radius)
	nav_component.set_move_speed(move_speed)
	health_component.max_health = max_health
	hurtbox.penetration_resistance = penetration_resistance
	hurtbox.faction = faction

func _process(delta):
	update_sprite_direction()

#endregion


#region Sprite adjust and highlights
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
func shoot_dmk(target : Vector2):
	bullet_spawner.transition_to("StateShooting", {
		'position' : position,
		'angle' : target.angle(),
	})

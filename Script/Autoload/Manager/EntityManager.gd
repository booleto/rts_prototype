extends Node

var game_entities : Node
var bullet_packed : PackedScene = preload("res://Scene/Bullet/bullet.tscn")
var unit_packed : PackedScene = preload("res://Scene/Unit/unit.tscn")

const CACUOICA : UnitData = preload("res://Resource/GameData/UnitData/Cacuoica/Cacuoica.tres")
const CADJTBU : UnitData = preload("res://Resource/GameData/UnitData/Cadjtbu/Cadjtbu.tres")
const CADJTLEP : UnitData = preload("res://Resource/GameData/UnitData/Cadjtlep/Cadjtlep.tres")

func spawn_dmk(bullet : Bullet):
	game_entities.add_child(bullet)

#TODO: spawn unit
func spawn_unit(position : Vector2, type : UnitData, faction : int) -> Unit:
	var unit = unit_packed.instantiate()
	unit.unit_data = type
	unit.position = position
	unit.faction = faction
	return unit

func spawn_building(position : Vector2):
	pass

#func initialize(level):
	#await(get_tree().tree_changed)
	#print(game_entities)


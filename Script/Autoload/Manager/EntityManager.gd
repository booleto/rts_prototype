extends Node

var game_entities : GameEntities
var game_areas : GameAreas
var game_statics : GameStatics

var bullet_packed : PackedScene = preload("res://Scene/Bullet/bullet.tscn")
var unit_packed : PackedScene = preload("res://Scene/Unit/unit.tscn")
var building_packed : PackedScene = preload("res://Scene/Building/building.tscn")

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

func spawn_building(position : Vector2, faction : int):
	var building : Building = building_packed.instantiate()
	building.faction = faction
	game_statics.add_child(building)
	building.position = position
	#rebake meshes
	#await building.ready
	var building_size = Vector2(Building.size, Building.size)
	var br : Rect2 = Rect2(position - building_size/2, building_size) #building.get_child(0).shape.get_rect()
	
	var building_polygon : Array[Vector2]
	building_polygon.append(br.position)
	building_polygon.append(Vector2(br.position.x, br.position.y + br.size.y))
	building_polygon.append(Vector2(br.position.x + br.size.x, br.position.y))
	building_polygon.append(Vector2(br.position.x + br.size.x, br.position.y + br.size.y))
	game_areas.change_areas(building_polygon)

#func initialize(level):
	#await(get_tree().tree_changed)
	#print(game_entities)


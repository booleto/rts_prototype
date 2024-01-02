extends Node

var game_entities : Node
var bullet_packed : PackedScene = preload("res://Scene/Bullet/bullet.tscn")

func spawn_dmk() -> Bullet:
	var dmk = bullet_packed.instantiate()
	game_entities.add_child(dmk)
	return dmk

#TODO: spawn unit
func spawn_unit() -> Unit:
	return null

#func initialize(level):
	#await(get_tree().tree_changed)
	#print(game_entities)


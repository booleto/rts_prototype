extends Node

var game_entities : Node
var bullet_packed : PackedScene = preload("res://Scene/Bullet/bullet.tscn")

func spawn_dmk(bullet : Bullet):
	game_entities.add_child(bullet)

#TODO: spawn unit
func spawn_unit() -> Unit:
	return null

#func initialize(level):
	#await(get_tree().tree_changed)
	#print(game_entities)


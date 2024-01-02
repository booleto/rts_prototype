extends Node

signal level_loaded(level)

var levels : Dictionary = {
	"main_menu" : load("res://Stage/MainMenu.tscn"),
	"test" : load("res://Stage/test.tscn")
}


func load_level(level_key : String):
	var level = levels.get(level_key)
	if level == null:
		return
	get_tree().change_scene_to_packed(level)
	level_loaded.emit(level)

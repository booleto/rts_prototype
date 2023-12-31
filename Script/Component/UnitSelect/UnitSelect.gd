extends Node
class_name UnitSelect

var selection : Array = []

func add_to_selection(arr : Array):	
	print(arr)
	for entry in arr:
		print(entry.position)
		if entry is Unit: entry.highlight()
	selection.append_array(arr)
	
func clear_selection():
	filter_invalids()
	for entry in selection:
		if entry is Unit: entry.disable_highlight()
	selection = []
	
func set_target(target : Vector2):
	filter_invalids()
	for unit in selection:
		unit.set_target(target)

func get_size():
	return selection.size()

func focused_shot(target : Vector2):
	filter_invalids()
	if selection.size() == 0:
		return
	for unit in selection:
		unit.shoot_dmk(target)

func filter_invalids():
	selection = selection.filter(func(unit): return is_instance_valid(unit) and unit is Unit)

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
	for entry in selection:
		if entry is Unit: entry.disable_highlight()
	selection = []
	
func set_target(target : Vector2):
	for unit in selection:
		if unit is Unit:
			unit.set_target(target)

func get_size():
	return selection.size()

func focused_shot(target : Vector2):
	var units = selection.filter(func(unit): return unit is Unit)
	if units.size() == 0:
		return
	for unit in units:
		unit.shoot_dmk(target)

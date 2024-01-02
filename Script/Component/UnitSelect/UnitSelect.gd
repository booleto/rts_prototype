extends Node
class_name UnitSelect

var selection : Array = []

func add_to_selection(arr : Array):	
	print(selection)
	for entry in arr:
		if entry is Unit:
			entry.highlight()
			#if not entry.tree_exiting.is_connected(filter_invalids):
				#entry.tree_exiting.connect(filter_invalids)
	selection.append_array(arr)
	
func clear_selection():
	filter_invalids()
	for entry in selection:
		if entry is Unit: entry.disable_highlight()
	selection = []
	
func set_target(target : Vector2):
	filter_invalids()
	#if selection.size() == 1:
		#selection[0].set_target(target)
	#var formation = _rect_formation(selection.size(), 30, target)
	#for i in selection.size():
		#selection[i].set_target(formation[i])
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

func _rect_formation(unit_count : int, spacing : float, origin : Vector2):
	var result = []
	var cols_count = round(sqrt(unit_count))
	var cols_spacing = cos(PI/6) * spacing
	var offset : float = sin(PI/6) * spacing

	var avg : Vector2 = Vector2.ZERO
	var temp_vec : Vector2	
	for i in range(unit_count):
		for j in range(cols_count):
			temp_vec.x = j * spacing + (j % 2) * offset
			temp_vec.y = cols_spacing * i
			avg += temp_vec
			result.append(temp_vec)
	
	avg /= unit_count
	#result.map(func(a): return a - avg + origin)
	for vec in result:
		vec -= avg - origin
	return result

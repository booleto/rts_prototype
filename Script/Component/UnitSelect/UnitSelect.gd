extends Node
class_name UnitSelect

var selection : Array[Unit] = []
var squads : Array[Array] = []
var unit_spacing : float = 50


func _ready():
	squads.resize(10)
	squads.fill([])


func add_to_selection(arr : Array):	
	for entry in arr:
		if entry is Unit:
			entry.highlight()
			#if not entry.tree_exiting.is_connected(filter_invalids):
				#entry.tree_exiting.connect(filter_invalids)
	selection.append_array(arr)
	#print(selection)


func save_squad(index : int):
	assert(index <= 9, "Invalid quad index")
	squads[index] = selection
	print_debug("squad saved: ", squads)

	
func select_squad(index : int):
	assert(index <= 9, "Invalid squad index")
	clear_selection()
	add_to_selection(squads[index])
	print_debug("squad selected", selection)


func has_squad(index : int):
	return squads[index].size() != 0


func clear_selection():
	filter_invalids()
	for entry in selection:
		if entry is Unit: entry.disable_highlight()
	selection = []

	
func set_target(target : Vector2):
	filter_invalids()
	if selection.size() == 1:
		selection[0].set_target(target)
	var formation = _rect_formation(selection.size(), unit_spacing, target)
	for i in selection.size():
		selection[i].set_target(formation[i])
	#for unit in selection:
		#unit.set_target(target)


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

	
func is_same_type() -> bool:
	if selection.size() == 0:
		return false
		
	var type : UnitData = selection[0].unit_data
	for unit in selection:
		if not unit.unit_data == type:
			return false
			
	return true


func _rect_formation(unit_count : int, spacing : float, origin : Vector2):
	var result = []
	var cols_count : int = round(sqrt(unit_count))
	var cols_spacing : float = cos(PI/6) * spacing
	var offset : float = sin(PI/6) * spacing

	var avg : Vector2 = Vector2.ZERO
	var temp_vec : Vector2	
	#print("units: ", unit_count)
	#print("cols: ", cols_count)

	for i in range(unit_count):
		var cols_idx = i % cols_count
		var rows_idx = int(floor(i / cols_count))
		temp_vec.x = cols_idx * spacing + (rows_idx % 2) * offset
		temp_vec.y = cols_spacing * rows_idx
		#print("temp_vec: ", temp_vec)
		avg += temp_vec
		result.append(temp_vec)
	
	avg /= unit_count
	#result.map(func(a): return a - avg + origin)
	for i in range(result.size()):
		#result[i] -= avg
		result[i] += origin - avg
	return result

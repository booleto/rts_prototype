extends Node
class_name BuildingManager

var selection : Array = []
var buildings : Array[Building] = []

func add_to_selection(building):
	for build in building:
		build.highlight()
	selection.append_array(building)
	
func clear_selection():
	for build in selection:
		build.disable_highlight()
	selection = []
	
func filter_invalids():
	selection = selection.filter(func(entry): return entry.is_instance_valid() and entry is Building)
	buildings = buildings.filter(func(entry): return entry.is_instance_valid() and entry is Building)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


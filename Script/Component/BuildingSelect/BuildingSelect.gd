extends Node
class_name BuildingSelect

var selection : Array = []

func add_to_selection(building):
	selection.append_array(building)
	
func clear_selection():
	selection = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


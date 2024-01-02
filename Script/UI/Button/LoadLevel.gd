extends Button
class_name LoadLevel

@export var level_key : String

func _ready():
	pressed.connect(load_level)
	
func load_level():
	GameManager.load_level(level_key)

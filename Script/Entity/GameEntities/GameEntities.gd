extends Node
class_name GameEntities

# Assign entities container for easy entity spawning
func _ready():
	EntityManager.game_entities = self

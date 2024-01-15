extends Node2D
class_name GameAreas

var areas : Array[NavigationRegion2D] = []

func _ready():
	EntityManager.game_areas = self
	areas.append_array(get_children().filter(func(entry): return entry is NavigationRegion2D))
	var level_navigation_map = get_world_2d().get_navigation_map()
	NavigationServer2D.map_set_edge_connection_margin(level_navigation_map, 10.0)	
	
func change_areas(arr : Array[Vector2]):
	var changed_areas = areas.filter(
		func(area : NavigationRegion2D):
			var polygon : PackedVector2Array = area.navigation_polygon.get_vertices()
			var intersect_arr = arr.filter(
				func(point : Vector2):
					return Geometry2D.is_point_in_polygon(point, polygon)
			)
			return intersect_arr.size() > 0
	)
	print_debug("Changed areas: ", changed_areas)
	changed_areas.map(
		func(area : NavigationRegion2D):
			area.bake_navigation_polygon(true)
	)

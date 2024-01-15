extends State
class_name StateBuilding

var intersect_query : RectIntersectQuery
var building_size : Vector2 = Vector2(Building.size, Building.size)
var draw_color : Color = Color.BLUE
var build_pos_valid : bool = false

func initialize():
	super()
	await actor.ready
	assert(actor is PlayerControl, "Player state assigned to non-player")
	intersect_query = actor.rect_intersect

func update(delta):
	super(delta)
	if Input.is_action_just_pressed("leftclick") and build_pos_valid:
		print_debug("spawn building")
		EntityManager.spawn_building(actor.get_global_mouse_position(), actor.faction)
	
	if Input.is_action_just_pressed("rightclick"):
		state_machine.transition_to("StatePlayerIdle", {})


func input_update(event):
	super(event)
	check_intersection(event)
	preview_building(event)
	

func preview_building(event):
	if event is InputEventMouseMotion:
		actor.queue_redraw()


func check_intersection(event):
	if not event is InputEventMouseMotion:
		return
	
	var mouse_pos = actor.get_global_mouse_position()
	var building_rect = Rect2(mouse_pos - building_size/2, building_size)
	var query_result : Array[Dictionary] = await intersect_query.query(building_rect.position, building_rect.end, 1)
	if not query_result.is_empty():
		draw_color = Color.RED
		#print("Cant build")
		build_pos_valid = false
	else:
		draw_color = Color.BLUE
		#print("yes build")
		build_pos_valid = true

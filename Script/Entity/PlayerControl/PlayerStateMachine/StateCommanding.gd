extends State
class_name StateCommanding

var unit_select : UnitSelect
var ui : UIComponent

func initialize():
	assert(actor is PlayerControl, "Non-player assigned as actor of player state")
	await actor.ready
	unit_select = actor.unit_select
	ui = get_tree().root.get_node("Main/UI")

func enter(params : Dictionary):
	super(params)
	actor.queue_redraw()
	if unit_select.is_same_type():
		ui.display_unit(unit_select.selection[0].unit_data)
		print_debug("display")


func update(_delta):
	#Add to selection
	if Input.is_action_pressed("shift") and Input.is_action_just_pressed("leftclick"):
		state_machine.transition_to("StateSelecting", {"mouse1_start" : actor.get_global_mouse_position()})
	
	#New selection	
	if Input.is_action_just_pressed("leftclick") and not Input.is_action_pressed("shift"):
		unit_select.clear_selection()
		state_machine.transition_to("StateSelecting", {"mouse1_start" : actor.get_global_mouse_position()})
	
	#Order movement
	if Input.is_action_just_pressed("rightclick"):
		unit_select.set_target(actor.get_global_mouse_position())
	
	#Focused shot	
	if Input.is_action_pressed("focused_shot"):
		unit_select.focused_shot(actor.get_global_mouse_position())
		
func exit():
	super()
	
func input_update(event):
	update_squad_save(event)
	update_squad_select(event)


func update_squad_save(event):
	if not (event is InputEventKey and event.ctrl_pressed):
		return
	var squad_index = actor.keycode_to_index(event.keycode)
	unit_select.save_squad(squad_index)
	
	
func update_squad_select(event):
	if not(event is InputEventKey and event.pressed):
		return
	
	var squad_index = actor.keycode_to_index(event.keycode)
	if squad_index == null or not unit_select.has_squad(squad_index): return
	unit_select.select_squad(squad_index)

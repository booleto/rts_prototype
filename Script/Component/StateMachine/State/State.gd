extends Node
class_name State

signal state_entered
signal state_exited

var actor
var state_machine : StateMachine

func initialize():
	pass

func enter(params : Dictionary):
	emit_signal("state_entered")

func update(_delta):
	pass

func input_update(event):
	pass
	
func physics_update(_delta):
	pass
	
func exit():
	emit_signal("state_exited")

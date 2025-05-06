class_name FiniteStateMachine
extends Node

var current_state = null
@export var actor: CharacterBody2D = null

var is_on = false

func _physics_process(delta):
	if not is_on:
		return 
	if current_state != null:
		if current_state.has_method("action_state"):
			current_state.action_state()
			
			
func set_state(new_state):
	current_state = new_state
	
	
func set_state_name(new_state):
	for s in get_children():
		if s.name_state == new_state:
			current_state = s
			
func get_state_name(new_state):
	for s in get_children():
		if s.name_state == new_state:
			return s
			
	return null

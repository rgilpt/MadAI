class_name SequenceStates
extends Node

var sequence = null
var step = -1
var has_started = false
@export var actor: CharacterBody2D = null
@export var finite_state_machine: FiniteStateMachine = null
#func _ready() -> void:
	#finite_state_machine = actor.get_node("FiniteStateMachine")
func load_sequence(file):
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		sequence = json_as_dict["sequence"]
		print(json_as_dict)
		
func start():
	if actor != null and sequence != null:
		step = 0
		has_started = true

func check_condition(conditions):
	for c in conditions:
		if c.has("action"):
			if c.action == "inventory":
				var amount = actor.get_amount_inventory(c.item)
				if amount >= c.amount:
					return true
	return false

func _process(delta: float) -> void:
	if has_started and step != -1:
		if check_condition(sequence[step].conditions):
			step += 1
		if step + 1 > len(sequence):
			has_started = false
			step = -1
		else:
			var state = finite_state_machine.get_state_name(sequence[step]["action"])
			if sequence[step].has("target_path"):
				print(sequence[step].target_path)
				var target = get_node("/root").get_child(0).get_node(sequence[step].target_path)
				if target != null:
					state.set_target(target)
			finite_state_machine.set_state(state)
			
			

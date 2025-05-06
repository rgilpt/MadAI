class_name HardcodedState
extends Node

@export var fsm:FiniteStateMachine
@export var fsm_path_finding: FSMPathFinding = null
@export var target:Node2D = null

func _ready() -> void:
	
	if fsm != null:
		if fsm_path_finding != null: 
			fsm.set_state(fsm_path_finding)

func set_harcoded_state(new_state=fsm_path_finding):
	fsm.set_state(new_state)

func set_target(new_target=target):
	fsm_path_finding.set_target(new_target)

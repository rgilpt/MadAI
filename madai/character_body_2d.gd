extends CharacterBody2D

var max_speed = 400
var my_speed = Vector2()

var inventory = []

var health = 100.0
var energy = 100.0
var ammo = 100.0

var max_health = 100.0
var max_energy = 100.0
var max_ammo = 100.0

@onready var health_bar: TextureProgressBar = $Health
@onready var energy_bar: TextureProgressBar = $Energy
@onready var ammo_bar: TextureProgressBar = $Ammo

@export var manual_control_enabled = false
@onready var finite_state_machine: FiniteStateMachine = $AI/Secondary/FiniteStateMachine
var _bot_ready = false
var engine_efficiency = 0.0002
#@onready var hardcoded_state: HardcodedState = $AI/Primary/HardcodedState
@onready var sequence_states: SequenceStates = $AI/Primary/SequenceStates

@onready var action_selection_component: ActionSelectionComponent = $AI/Primary/ActionSelectionComponent

@onready var memory_locations: MemoryLocations = $AI/MemoryLocations

func update_bars():
	health_bar.value = health / max_health * 100
	energy_bar.value = energy / max_energy * 100
	ammo_bar.value = ammo / max_ammo * 100

func handle_inputs():
	
	if Input.is_action_pressed("ui_down"):
		my_speed.y = 1
	elif Input.is_action_pressed("ui_up"):
		my_speed.y = -1
	else:
		my_speed.y = 0
	
	if Input.is_action_pressed("ui_left"):
		my_speed.x = -1
	elif Input.is_action_pressed("ui_right"):
		my_speed.x = 1
	else:
		my_speed.x = 0
	
	my_speed = my_speed.normalized()
	
	
	if energy < 0:
		my_speed = Vector2()

func bot_movement():
	finite_state_machine.is_on = true

func bot_main_loop():
	bot_movement()

func _physics_process(delta: float) -> void:
	if not _bot_ready:
		#hardcoded_state.set_harcoded_state()
		#hardcoded_state.set_target()
		
		# Using Sequence
		sequence_states.load_sequence("res://data/sequence1.json")
		sequence_states.start()
		
		# Using NN1
		#action_selection_component.init()
		#action_selection_component.load_tranning_data()
		#action_selection_component.train()
		#
		#action_selection_component.start()
		
		
		_bot_ready = true
	if manual_control_enabled:
		finite_state_machine.is_on = false
		handle_inputs()
		
	else:
		finite_state_machine.is_on = true
		#bot_main_loop()
		
	
	update_bars()
	
	velocity = my_speed * max_speed
	energy -= velocity.length() * engine_efficiency
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Collect"):
		inventory.append({'name': body.item_name})
		memory_locations.remove_memory(body)
		body.queue_free()
		action_selection_component.set_get_next_action = true
	elif body.is_in_group("ChangeLevel"):
		var is_open = body.check_requirements(inventory)
		if is_open:
			get_tree().change_scene_to_file(body.target)

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	energy -= velocity.length() * engine_efficiency
	move_and_slide()
	
func get_amount_inventory(item_name:String):
	var count = 0
	for item in inventory:
		if item.name == item_name:
			count += 1
	return count

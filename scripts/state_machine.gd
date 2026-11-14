class_name StateMachine
extends Node

signal state_changed(state: State)

const MAX_STATE_HISTORY : int = 3

@export var initial_state : GDScript

@export_group("Dependencies")
@export var actor: CharacterBody2D
@export var data: Data
@export var input_component : InputComponent

var current_state : State 
var state_history : Array[State] = []

func _ready() -> void:
	if initial_state:
		_transition_to(initial_state)
		
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _physics_process(delta: float) -> void:
	if current_state: 
		current_state.physics_update(delta)
		
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
func _transition_to(new_state_class: GDScript) -> void:
	var new_state = new_state_class.new()
	
	if not new_state is State:
		push_error("Invalid State Class of FMS : %s" % owner.name)
		return
	if current_state == new_state:
		return
	if current_state:
		current_state.exit()
		current_state = null
	
	current_state = new_state
	current_state.setup(actor, data, input_component)
	current_state.transitioned.connect(_transition_to)
	
	_update_state_history(current_state)
	
	current_state.enter(state_history)
	state_changed.emit(current_state)
	
func _update_state_history(state : State) -> void:
	state_history.push_front(state)
	
	if state_history.size() > MAX_STATE_HISTORY:
		state_history.pop_back()
		

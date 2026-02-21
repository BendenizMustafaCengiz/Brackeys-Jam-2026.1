extends Node
var current_state : State
var states : Dictionary = {}

@export var initial_state : State
@export var state_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	current_state.input(event)

 
func on_child_transitioned(state : State, new_state_name : String) -> void:
# state anlık statee, new_state_name geçmek istenen statein ismi
	if state != current_state:
		#push_error("aktif olmayan ",state.name ," state'i",new_state_name, "'e geçmek için sinyal yolladı: ")
		return
	
	var new_state = states[new_state_name.to_lower()]
	if not new_state:
		push_error("böyle bir state adı yok")
		return
		
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
	if state_label:
		state_label.text = new_state_name



func change_state(new_state_name : String) -> void:
	# on_child_transitioned fonksyonunun aynısı, signal yollamadan geçiş yapabilmek için 
	var new_state = states[new_state_name.to_lower()]
	if not new_state:
		push_error("böyle bir state adı yok")
		
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
	if state_label:
		state_label.text = new_state_name

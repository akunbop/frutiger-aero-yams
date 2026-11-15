extends Dispenser
class_name ToppingDispenser

@export var topping_meshes := preload("res://scenes/blue_liquid.tscn")
@export var gold_fish : Mesh
@export var boba : Mesh
@export var icecubes: Mesh
@export var jellyfish : Mesh

var array_id : int = 3


enum DispenserType {GOLD_FISH, BOBA, ICECUBES, JELLYFISH}
var _type : DispenserType = DispenserType.GOLD_FISH
var current_mesh : Mesh = gold_fish

func _ready() -> void:
	print("dispenser script ready: ", name)
	set_dispenser_type(DispenserType.GOLD_FISH)

func set_dispenser_type(new_type : DispenserType):
	_type = new_type
	print("setting type ", new_type)
	match new_type:
		DispenserType.GOLD_FISH:
			current_mesh = gold_fish
		DispenserType.BOBA:
			current_mesh = boba
		DispenserType.ICECUBES:
			current_mesh = icecubes
		DispenserType.JELLYFISH:
			current_mesh = jellyfish

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		print("test action fired")

#func _unhandled_input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("test"):
		#print("key: ", event.as_text(), " keycode: ", event.keycode)
		#print("pressed F12")
		#set_dispenser_type(DispenserType.BOBA)
		#dispense()
	#if Input.is_action_just_pressed("test2"):
		#set_dispenser_type(DispenserType.GOLD_FISH)
		#dispense()
	#if Input.is_action_just_pressed("test3"):
		#set_dispenser_type(DispenserType.ICECUBES)
		#dispense()
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		print("key: ", event.as_text(), " keycode: ", event.keycode)
		print("pressed F12")
		set_dispenser_type(DispenserType.BOBA)
		dispense()
	if Input.is_action_just_pressed("test2"):
		set_dispenser_type(DispenserType.GOLD_FISH)
		dispense()
	if Input.is_action_just_pressed("test3"):
		set_dispenser_type(DispenserType.JELLYFISH)
		dispense()

func dispense():
	super.dispense()
	var instance : Fluid = topping_meshes.instantiate()
	add_child(instance)
	instance.fluid_renderer.multimesh.mesh = current_mesh
	print(instance.fluid_renderer.multimesh.mesh)



func _on_goldfish_button_pressed() -> void:
	set_dispenser_type(DispenserType.GOLD_FISH)
	dispense()

func _on_boba_button_pressed() -> void:
	print("pressed F12")
	set_dispenser_type(DispenserType.BOBA)
	dispense()
func _on_ice_cube_button_pressed() -> void:
	set_dispenser_type(DispenserType.ICECUBES)
	dispense()

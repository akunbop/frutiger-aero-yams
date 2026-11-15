extends Dispenser
class_name ToppingDispenser

@export var topping_meshes := preload("res://scenes/blue_liquid.tscn")
@export var gold_fish : Mesh

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		dispense()

func dispense():
	super.dispense()
	var instance : Fluid = topping_meshes.instantiate()
	add_child(instance)
	instance.fluid_renderer.multimesh.mesh = gold_fish
	print(instance.fluid_renderer.multimesh.mesh)

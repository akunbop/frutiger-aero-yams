extends Node3D

@export_category("dispenser")
@export var glas_dispenser : GlasDispenser 
@export var fluid_dispenser : Dispenser
@export var syrup_dispenser : Dispenser
@export var topping_dispenser : ToppingDispenser
@export var deco_dispenser : Dispenser

@export var belts : Array[Belt] = []
var glasses : Array[Glass] = []

func _ready():
	fluid_dispenser.dispensed.connect(fluid_dispenser_dispensed)
	syrup_dispenser.dispensed.connect(syrup_dispenser_dispensed)
	topping_dispenser.dispensed.connect(topping_dispenser_dispensed)
	deco_dispenser.dispensed.connect(deco_dispenser_dispensed)
	
func GlasStationEntered(body: Node3D) -> void:
	if body is Glass:
		glasses.append(body)
		body.glas_type = glas_dispenser._type

func fluid_dispenser_dispensed(dispenser: FluidDispenser):
	return

func FluidStationEntered(body: Node3D) -> void:
	pass # Replace with function body.


func MixerStationEntered(body: Node3D) -> void:
	pass # Replace with function body.

func syrup_dispenser_dispensed(dispenser: SyrupDispenser):
	return

func ToppingStationEntered(body: Node3D) -> void:
	pass # Replace with function body.

func topping_dispenser_dispensed(dispenser: ToppingDispenser):
	return

func DecoStationEntered(body: Node3D) -> void:
	pass # Replace with function body.

func deco_dispenser_dispensed(dispenser: DecoDispenser):
	return

extends Node3D

@export_category("dispenser")
@export var glas_dispenser : Dispenser 
@export var fluid_dispenser : Dispenser
@export var syrup_dispenser : Dispenser
@export var topping_dispenser : Dispenser
@export var deco_dispenser : Dispenser

var belts : Array[Belt] = []
var glasses : Array[Glass] = []

func _ready():
	return


func GlasStationEntered(body: Node3D) -> void:
	if body is Glass:
		glasses.append(body)

func FluidStationEntered(body: Node3D) -> void:
	pass # Replace with function body.


func MixerStationEntered(body: Node3D) -> void:
	pass # Replace with function body.


func ToppingStationEntered(body: Node3D) -> void:
	pass # Replace with function body.


func DecoStationEntered(body: Node3D) -> void:
	pass # Replace with function body.

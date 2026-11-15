extends Node3D

@export_category("dispenser")
@export var glas_dispenser : Dispenser 
@export var fluid_dispenser : Dispenser
@export var syrup_dispenser : Dispenser
@export var topping_dispenser : Dispenser
@export var deco_dispenser : Dispenser

var glass: Dictionary = {
	"normal_glass": false, 
	"bubble_glass": false,
	"lava_glass": false,
	"wonky_glass": false
	}
var liquid: Dictionary = {
	"seethrough_liquid": false,
	"blue_liquid": false, 
	"green_liquid": false
	}
var mixer: Dictionary = {
	"blue_mixer": false,
	"green_mixer": false,
	"orange_mixer": false
	}
var toppings: Dictionary = {
	"boba_topping": false, 
	"icecubes_topping": false, 
	"lava_topping": false, 
	"goldfish_topping": false, 
	"jellyfish_topping": false
	}
var deco: Dictionary = {
	"plastic_skyline_deco": false,
	"plastic_dolphins_deco": false,
	"bubbly_meeples_deco": false,
	"plastic_umbrella_deco": false
	}

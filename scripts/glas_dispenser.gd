extends Dispenser
class_name GlasDispenser


var bubble_glas := preload("res://scenes/glas_mesh_rigid/bubble_glass_rigid.tscn")
var lavalamp_glas := preload("res://scenes/glas_mesh_rigid/lavalamp_glass_rigid.tscn")
var normal_glas := preload("res://scenes/glas_mesh_rigid/normal_glass_rigid.tscn")
var wonky_glas := preload("res://scenes/glas_mesh_rigid/wonky_glass_rigid.tscn")


enum GlasType {BUBBLE, LAVALAMP, NORMAL, WONKY}
var _type : GlasType = GlasType.NORMAL
var current_glas : PackedScene
var array_id : int = 0

#
#func _ready() -> void:
	#set_dispenser_type(GlasType.NORMAL)

func set_dispenser_type(new_type : GlasType):
	_type = new_type
	print("setting type ", new_type)
	match new_type:
		GlasType.BUBBLE:
			current_glas = bubble_glas
			dispense()
		GlasType.LAVALAMP:
			current_glas = lavalamp_glas
			dispense()
		GlasType.NORMAL:
			current_glas = normal_glas
			dispense()
		GlasType.WONKY:
			current_glas = wonky_glas
			dispense()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test4"):
		print("dispensing bubble glas")
		set_dispenser_type(GlasType.BUBBLE)

func dispense():
	var instance = current_glas.instantiate()
	add_child(instance)

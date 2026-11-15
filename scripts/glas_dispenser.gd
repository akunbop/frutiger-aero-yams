extends Dispenser
class_name GlasDispenser


var bubble_glas := preload("res://scenes/glas_mesh_rigid/bubble_glass_rigid.tscn")
var lavalamp_glas := preload("res://scenes/glas_mesh_rigid/lavalamp_glass_rigid.tscn")
var normal_glas := preload("res://scenes/glas_mesh_rigid/normal_glass_rigid.tscn")
var wonky_glas := preload("res://scenes/glas_mesh_rigid/wonky_glass_rigid.tscn")


enum GlasType {BUBBLE, LAVALAMP, NORMAL, WONKY}
var _type : GlasType = GlasType.NORMAL
var current_glas : PackedScene
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
	if event.is_action_pressed("test4"):
		print("dispensing bubble glas")
		set_dispenser_type(GlasType.BUBBLE)

	elif event.is_action_pressed("test5"):
		print("dispensing lavalamp glas")
		set_dispenser_type(GlasType.LAVALAMP)

	elif event.is_action_pressed("test6"):
		print("dispensing normal glas")
		set_dispenser_type(GlasType.NORMAL)

	elif event.is_action_pressed("test7"):
		print("dispensing wonky glas")
		set_dispenser_type(GlasType.WONKY)

func dispense():
	var instance = current_glas.instantiate()
	add_child(instance)

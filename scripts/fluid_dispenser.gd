extends Dispenser
class_name FluidDispenser

@export var glas_dispenser: GlasDispenser

@export var hellgruen: Color = Color("#B8F2C2")
@export var hellblau: Color = Color("#ADE0F5")
@export var weiss: Color = Color.WHITE


var _current_color: Color = Color.WHITE

var array_id : int = 1


enum FluidType {
	WHITE, LIGHT_BLUE, LIGHT_GREEN
}
var fluid_type : FluidType = FluidType.WHITE

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test8"):
		set_fluid_color(hellgruen)

	elif event.is_action_pressed("test9"):
		set_fluid_color(hellblau)

	elif event.is_action_pressed("test10"):
		set_fluid_color(weiss)


func set_fluid_color(new_color: Color) -> void:
	_current_color = new_color
	dispense()


func dispense() -> void:
	super.dispense()
	var liquid := _get_latest_base_liquid()

	if liquid == null:
		push_warning("FluidDispenser: Kein Becher mit BaseLiquid vorhanden.")
		return

	if liquid.mesh == null or liquid.mesh.get_surface_count() == 0:
		push_warning("FluidDispenser: BaseLiquid hat kein gültiges Mesh.")
		return

	var source_material := liquid.get_active_material(0)
	var liquid_material: BaseMaterial3D

	if source_material is BaseMaterial3D:
		# Eigene Kopie, damit andere Becher ihre Farbe behalten.
		liquid_material = source_material.duplicate() as BaseMaterial3D
	elif source_material == null:
		liquid_material = StandardMaterial3D.new()
	else:
		push_warning(
			"FluidDispenser: BaseLiquid benötigt ein StandardMaterial3D "
			+ "oder ORMMaterial3D, kein ShaderMaterial."
		)
		return

	liquid_material.albedo_color = _current_color
	liquid.material_override = liquid_material
	liquid.show()


func _get_latest_base_liquid() -> MeshInstance3D:
	if not is_instance_valid(glas_dispenser):
		push_warning("FluidDispenser: GlasDispenser im Inspector zuweisen.")
		return null

	# Rückwärts suchen: Der zuletzt hinzugefügte Becher kommt zuerst.
	var glasses := glas_dispenser.get_children()

	for index in range(glasses.size() - 1, -1, -1):
		var glass := glasses[index]

		if glass.is_queued_for_deletion():
			continue

		var liquid := glass.get_node_or_null("BaseLiquid") as MeshInstance3D

		if liquid != null:
			return liquid

	return null

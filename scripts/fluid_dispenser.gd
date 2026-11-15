extends Dispenser
class_name FluidDispenser

var array_id : int = 1


enum FluidType {
	WHITE, LIGHT_BLUE, LIGHT_GREEN
}
var fluid_type : FluidType = FluidType.WHITE

func dispense():
	super.dispense()

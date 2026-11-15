extends Dispenser
class_name SyrupDispenser


var array_id : int = 2


enum SyrupType {
	YELLOW, GREEN, BLUE
}
var syrup_type: SyrupType = SyrupType.YELLOW

func dispense():
	super.dispense()

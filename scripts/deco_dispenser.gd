extends Dispenser
class_name DecoDispenser

var array_id : int = 4


enum DecoType {
	SKYLINE, UMBRELLA, MEEPLE
}
var deco_type : DecoType = DecoType.SKYLINE
func dispense():
	super.dispense()

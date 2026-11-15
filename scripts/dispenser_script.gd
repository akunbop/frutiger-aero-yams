extends Node3D
class_name Dispenser

signal dispensed()

func dispense():
	dispensed.emit(self)
	

extends Node3D

var order = ""
var index = -1 
var leaving := false
@onready var client_skin = $FrutigerPerson
@onready var label = $FrutigerPerson/Sprite3D/SubViewport/Label

func _ready() -> void:
	label.text = '...'
	label.text = order.replace("_", ' ')
	await get_tree().create_timer(25.0).timeout
	leaving = true
	get_parent().get_parent().free_spot(index)
	queue_free()
	get_parent().get_parent().get_parent().remove_balance(order)


func set_order(new_order):
	order = new_order
	label.text = order

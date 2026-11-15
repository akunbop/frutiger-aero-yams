extends Node2D

@export var client_scene: PackedScene

@onready var positions = [$Position1, $Position2, $Position3, $Position4]
var positions_occupied = []



func _on_spawentimer_timeout() -> void:
	if positions_occupied.size() >= 4:
		return
	
	var i = 0
	while i <= 3:
		if not positions_occupied.has(i):
			var index = i 
			var client = client_scene.instantiate()
			client.index = index 
			client.set_order(pick_random_order())
			positions[index].add_child(client)
			positions_occupied.append(i)
			i = 10
		i += 1

func pick_random_order():
	var orders = ["cola", "cola", "cola", "hamburger", "cheeseburger", "double_hamburger", "double_cheeseburger", "triple_hamburger", "triple_cheeseburger"]
	return orders[randi() % orders.size()]

func free_spot(index: int):
	positions_occupied.erase(index)

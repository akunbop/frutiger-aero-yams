extends Node3D

@export var client_scene: PackedScene
@onready var positions = [$Posititon0, $Posititon1, $Posititon2, $Posititon3]
var positions_occupied = []


func _on_spawntimer_timeout() -> void:
	if positions_occupied.size() >= 4:
		return
	var i = 0
	print("1")
	while i <= 3:
		if not positions_occupied.has(i):
			print("2")
			var index = i 
			var client = client_scene.instantiate()
			client.index = index 
			print("3")
			client.set_order(pick_random_order())
			positions[index].add_child(client)
			print("4")
			positions_occupied.append(i)
			i = 10
		i += 1
		print("5")

func pick_random_order():
	var orders = ["cola", "cola", "cola", "hamburger", "cheeseburger", "double_hamburger", "double_cheeseburger", "triple_hamburger", "triple_cheeseburger"]
	return orders[randi() % orders.size()]

func free_spot(index: int):
	positions_occupied.erase(index)

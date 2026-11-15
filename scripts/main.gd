extends Node2D


@export var plate: Node2D
@export var cooker: Node2D

var item_held = 'none'
var balance = 0.0
var total_drinks_sold = 0.0

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, -32)
	$CanvasLayer/HBoxContainer/DrinksSold.text = ' Total Drinks sold: ' + str(total_drinks_sold) + " "
	$CanvasLayer/HBoxContainer/Balance.text = ' Balance: ' + str(balance) + "€ "
	$IngredientsLayer/TomatoButton.pressed.connect(func(): on_ingredient_pressed('tomato'))
	$IngredientsLayer/LettuceButton.pressed.connect(func(): on_ingredient_pressed('lettuce'))
	$IngredientsLayer/MeatButton.pressed.connect(func(): on_ingredient_pressed('meat'))
	$IngredientsLayer/CheeseButton.pressed.connect(func(): on_ingredient_pressed('cheese'))
	$IngredientsLayer/BunButton.pressed.connect(func(): on_ingredient_pressed('bun'))
	$Cooker/CookedMeatButton.pressed.connect(func(): on_cooker_pressed())
	
func on_ingredient_pressed(name: String):
	if name == 'meat':
		if not cooker.is_busy:
			cooker.start_cooking()
		return
	$IngredientsLayer/AudioStreamPlayer.play()
	plate.add_ingredient(name)
	
func on_cooker_pressed():
	if cooker.burned:
		cooker.reset()
		return
	if cooker.cooked and not plate.top_bun_added and plate.bottom_bun_added:
		on_ingredient_pressed('cooked_meat')
		cooker.reset()

func reset_plate() -> void:
	if $Plate/Burger.get_child_count() > 0:
		for i in $Plate/Burger.get_children():
			i.queue_free()
	plate.stack = []
	plate.bottom_bun_added = false
	plate.meat_added = false
	plate.top_bun_added = false
	plate.has_cheese = false
	plate.plate_name = 'none'
	plate.meat_counter = 0 


func _on_plate_button_pressed() -> void:
	if item_held == 'none':
		item_held = $Plate.plate_name

func append_balance(type):
	if type == 'cola':
		balance += 2.99
	elif type == 'hamburger':
		balance += 5.99
	elif type == 'cheeseburger':
		balance += 9.99
	elif type == 'double_hamburger':
		balance += 13.99
	elif type == 'double_cheeseburger':
		balance += 14.99
	elif type == 'triple_hamburger':
		balance += 18.99
	elif type == 'triple_cheeseburger':
		balance += 19.99
	if not type == 'cola':
		total_drinks_sold += 1
	$CanvasLayer/HBoxContainer/DrinksSold.text = ' Total Drinks sold: ' + str(total_drinks_sold) + " "
	$CanvasLayer/HBoxContainer/Balance.text = ' Balance: ' + str(balance) + "€ "
	$MoneyAppendedSound.play()
	save_settings()

func remove_balance(type):
	if type == 'cola':
		balance -= 0.99
	elif type == 'hamburger' or type == 'cheeseburger':
		balance -= 1.99
	elif type == 'double_hamburger' or type == 'double_cheeseburger':
		balance -= 2.99
	elif type == 'triple_hamburger' or type == 'triple_cheeseburger':
		balance -= 3.99
	$CanvasLayer/HBoxContainer/DrinksSold.text = ' Total Drinks sold: ' + str(total_drinks_sold) + " "
	$CanvasLayer/HBoxContainer/Balance.text = ' Balance: ' + str(balance) + "€ "
	$MoneyRemovedSound.play()
	save_settings()
	

func _on_trash_button_pressed() -> void:
	$TrashSound.play()
	if not item_held == 'cola' and not item_held == 'none':
		reset_plate()
	item_held = 'none'
	
var _loaded= false
var _save_path = 'user://burger.ingredients'
func _enter_tree() -> void:
	if _loaded:
		printerr("Error: Settings is an AutoLoad singleton and it shouldn't be instanced elsewhere.")
		printerr("Please delete the instance at: " + String(get_path()))
	else:
		_loaded = true
	
	if FileAccess.file_exists(_save_path):
		var file = FileAccess.open(_save_path, FileAccess.READ)
		var data = file.get_var()
		if data == null: return
		if "balance" in data:
			balance = data["balance"]
		if "total_drinks_sold" in data:
			total_drinks_sold = data["total_drinks_sold"]
		file.close()
	else:
		save_settings()

func save_settings():
	var file = FileAccess.open(_save_path, FileAccess.WRITE)
	var data = {
		"balance": balance,
		"total_drinks_sold": total_drinks_sold,
	}
	file.store_var(data)
	file.close()

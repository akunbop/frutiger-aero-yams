extends Node2D

@export var spacing := -5 

var stack := []
var bottom_bun_added := false
var meat_added := false
var top_bun_added := false

var meat_counter = 0
var has_cheese = false
var plate_name = ''

func add_ingredient(type: String): 
	if top_bun_added: return
	if not bottom_bun_added and not type == 'bun':
		return
	if type == 'bun':
		if bottom_bun_added == false:
			bottom_bun_added = true
			type = 'bottom_bun'
		else:
			type = 'top_bun'
			top_bun_added = true
	get_burger_name(type)
	var path = "res://assets/objects/placeholder/" + type + ".png"
	var texture = load(path)
	
	var sprite = Sprite2D.new()
	sprite.name = type + str(stack.size())
	sprite.texture = texture
	sprite.scale = Vector2(2.8, 2.8)
	sprite.position = Vector2(0, spacing * stack.size())
	$Burger.add_child(sprite)
	stack.append(sprite)
	
func get_burger_name(type):
	if type == 'cooked_meat':
		meat_counter += 1
	if type == 'cheese':
		has_cheese = true
	
	if meat_counter == 0:
		plate_name = 'invalid_burger'
	elif meat_counter == 1: 
		if has_cheese: 
			plate_name = 'cheeseburger'
		else:
			plate_name = 'hamburger'
	elif meat_counter == 2: 
		if has_cheese: 
			plate_name = 'double_cheeseburger'
		else:
			plate_name = 'double_hamburger'
	elif meat_counter == 3: 
		if has_cheese: 
			plate_name = 'triple_cheeseburger'
		else:
			plate_name = 'triple_hamburger'
	elif meat_counter > 3:
		plate_name = 'invalid_burger'

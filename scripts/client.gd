extends Node2D

var order = ""
var index = -1 
var leaving := false
@onready var angry_progress_bar_style = preload("res://assets/objects/placeholder/client_progress_bar_angry.tres")
@onready var clients = [preload("res://assets/objects/placeholder/client1.png"), preload("res://assets/objects/placeholder/client2.png")]

func _ready() -> void:
	$TextureButton.texture_normal = clients[randi_range(0, 1)]
	$TextureButton.texture_pressed = $TextureButton.texture_normal
	$TextureButton.texture_hover = $TextureButton.texture_normal
	$TextureButton.texture_focused = $TextureButton.texture_normal
	$TextureButton/VBoxContainer/Label.text = '...'
	$OrderSound.play()
	await $OrderSound.finished
	$TextureButton/VBoxContainer/Label.text = order.replace("_", ' ')
	var tween = create_tween()
	tween.tween_property($TextureButton/VBoxContainer/ProgressBar, "value", 100, 25.0)
	await get_tree().create_timer(25.0).timeout
	leaving = true
	$AngrySound.play()
	$TextureButton/VBoxContainer/ProgressBar.remove_theme_stylebox_override("fill")
	$TextureButton/VBoxContainer/ProgressBar.add_theme_stylebox_override("fill", angry_progress_bar_style)
	await get_tree().create_timer(1.64).timeout
	get_parent().get_parent().free_spot(index)
	queue_free()
	get_parent().get_parent().get_parent().remove_balance(order)
	
func serve(item):
	if leaving: return
	if order == item:
		get_parent().get_parent().free_spot(index)
		get_parent().get_parent().get_parent().item_held = 'none'
		get_parent().get_parent().get_parent().append_balance(order)
		if not order == 'cola':
			get_parent().get_parent().get_parent().reset_plate()
		await get_tree().create_timer(1).timeout
		queue_free()
	else: 
		$Confused.play()
		
func _on_texture_button_pressed() -> void:
	serve(get_parent().get_parent().get_parent().item_held)

func set_order(new_order):
	order = new_order
	$TextureButton/VBoxContainer/Label.text = order

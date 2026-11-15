extends Node2D

var is_busy := false
var filled := false
var fill_time := 6.0

var drink_cup_texture = preload("res://assets/objects/placeholder/cola.png")

func _ready() -> void:
	$MachineButton.pressed.connect(func(): on_cola_machine_pressed())

func on_cola_machine_pressed():
	if filled: 
		if get_parent().item_held == 'none':
			is_busy = false
			filled = false
			$Cola.texture = null
			$ProgressBar.value = 0
			get_parent().item_held = 'cola'
			return
	if is_busy:
		return
	$Cola.texture = drink_cup_texture
	$ColaFilling.play()
	is_busy = true
	filled = false
	$ProgressBar.value = 0
	var tween = create_tween()
	tween.tween_property($ProgressBar, "value", 100, fill_time)
	await get_tree().create_timer(fill_time).timeout
	filled = true
	

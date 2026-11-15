extends Node2D

var uncooked_texture = preload("res://assets/objects/placeholder/cooker_uncooked_meat.png")
var cooked_texture = preload("res://assets/objects/placeholder/cooker_cooked_meat.png")
var burned_texture = preload("res://assets/objects/placeholder/cooker_burned_meat.png")

var is_busy := false
var cooked := false
var burned := false
var cook_time := 4.0

signal meat_cooked

func start_cooking():
	if is_busy: 
		return
	$MeatTexture.texture = uncooked_texture
	$CookingSound.play()
	is_busy = true
	cooked = false
	burned = false 
	await get_tree().create_timer(cook_time).timeout
	cooked = true
	$MeatTexture.texture = cooked_texture
	meat_cooked.emit()
	await get_tree().create_timer(cook_time).timeout
	if is_busy == true and cooked == true:
		$CookingSound.stop()
		$BurnedSound.play()
		$MeatTexture.texture = burned_texture
		burned = true

func reset():
	$CookingSound.stop()
	$MeatTexture.texture = null
	is_busy = false
	cooked = false
	burned = false

extends Node3D

const STATION_COUNT: int = 5

var areas: Array[Area3D] = []
var snap_points: Array[Marker3D] = []

# Index 0 entspricht Station 1, Index 4 entspricht Station 5.
var slots: Array[RigidBody3D] = []

var pending_moves: Array[int] = []


func _ready() -> void:
	slots.resize(STATION_COUNT)
	slots.fill(null)

	for i in range(STATION_COUNT):
		var area := get_node(str(i + 1)) as Area3D
		var snap := area.get_node("SnapPoint") as Marker3D

		areas.append(area)
		snap_points.append(snap)


func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return

	var key_event := event as InputEventKey

	if not key_event.pressed or key_event.echo:
		return

	match key_event.keycode:
		KEY_A, KEY_LEFT:
			pending_moves.append(-1)
			get_viewport().set_input_as_handled()

		KEY_D, KEY_RIGHT:
			pending_moves.append(1)
			get_viewport().set_input_as_handled()


func _physics_process(_delta: float) -> void:
	_clear_invalid_slots()
	_register_detected_glasses()

	while not pending_moves.is_empty():
		_move_glasses(pending_moves.pop_front())


func _clear_invalid_slots() -> void:
	for i in range(STATION_COUNT):
		if not is_instance_valid(slots[i]):
			slots[i] = null


func _register_detected_glasses() -> void:
	for i in range(STATION_COUNT):
		for body in areas[i].get_overlapping_bodies():
			if not body is RigidBody3D:
				continue

			var glass := body as RigidBody3D

			if not glass.is_in_group("glasses"):
				continue

			if glass.is_queued_for_deletion():
				continue

			# Bereits registrierte Gläser nicht erneut zuordnen.
			if slots.has(glass):
				continue

			if slots[i] != null:
				# Sicherheitsregel: Zusätzliche Gläser entfernen.
				push_warning(
					"Station %d ist bereits belegt." % (i + 1)
				)
				glass.queue_free()
				continue

			_place_glass(glass, i)


func _place_glass(glass: RigidBody3D, index: int) -> void:
	slots[index] = glass

	# Auf dem Band steuert dieses Script die Position,
	# nicht die Physiksimulation.
	glass.freeze = true
	glass.linear_velocity = Vector3.ZERO
	glass.angular_velocity = Vector3.ZERO
	glass.global_position = snap_points[index].global_position


func _move_glasses(direction: int) -> void:
	if direction == -1:
		# Links beginnen, damit frei werdende Plätze
		# im selben Schritt nachbesetzt werden können.
		for i in range(STATION_COUNT):
			_try_move_glass(i, direction)
	else:
		# Nach rechts entsprechend rechts beginnen.
		for i in range(STATION_COUNT - 1, -1, -1):
			_try_move_glass(i, direction)


func _try_move_glass(index: int, direction: int) -> void:
	var glass := slots[index]

	if glass == null:
		return

	var target: int = index + direction

	# Links von Station 1 ist Schluss.
	if target < 0:
		return

	# Rechts von Station 5 verschwindet das Glas.
	if target >= STATION_COUNT:
		slots[index] = null
		glass.queue_free()
		return

	# Besetzter Platz: Glas bleibt stehen.
	if slots[target] != null:
		return

	slots[index] = null
	_place_glass(glass, target)

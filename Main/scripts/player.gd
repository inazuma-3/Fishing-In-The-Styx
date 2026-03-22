extends CharacterBody3D

var bobber: RigidBody3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _input(event):
	# load in bobber
	var bobber_scene = preload("res://Main/scenes/System/Player/bobber.tscn").instantiate()
	
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		get_tree().root.add_child(bobber_scene)
		# set ball's position to farther than the play's position
		bobber_scene.global_position = global_position
		
		# prevent ball and player from touching
		bobber_scene.get_node("Bobber").add_collision_exception_with(self)

func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# input direction
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Player collision into fish
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody2D:
			pass

extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 7
var jumps = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jumps < 1:
		velocity.y = JUMP_VELOCITY
		jumps += 1
	
	if is_on_floor() and jumps != 0:
		jumps = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_left", "move_right")
	var direction := (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	$"PlayerAnim".play("new_animation_library/strut_walking")

	move_and_slide()

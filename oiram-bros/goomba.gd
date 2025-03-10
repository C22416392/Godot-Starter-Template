extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := -5.0
	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

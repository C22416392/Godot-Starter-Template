extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var turnL: Area2D = $TurnAroundL
@onready var turnR: Area2D = $TurnAroundR

const SPEED = 600.0
const JUMP_VELOCITY = -400.0

var direction := -1.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# flips direction travelling in
func turnAround():
	print("Turn")
	# Travelling left	
	if direction < 0:
		turnL.monitoring = false
		turnR.monitoring = true
		direction = 1
	# Travelling right
	elif direction > 0:
		turnL.monitoring = true
		turnR.monitoring = false
		direction = -1

# Kills enemy
func _on_hitbox_body_entered(body: Node2D) -> void:
	# If player in air
	if not body.is_on_floor():
		sprite.offset.y = -5
		collision.shape.size.y = 1
		
		direction = 0.0
		sprite.frame = 2
		
		await get_tree().create_timer(2).timeout
		self.queue_free()


func _on_turn_around_r_body_entered(body: Node2D) -> void:
	if body != self:
		turnAround()

func _on_turn_around_l_body_entered(body: Node2D) -> void:
	print("ENTER L")
	if body != self:
		turnAround()


func _on_turn_around_r_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print(body)

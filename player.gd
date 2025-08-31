extends CharacterBody2D

const SPEED := 400.0
const JUMP_VELOCITY := -900.0

@onready var inner_peace: Sprite2D = $InnerPeace
@onready var knight: AnimatedSprite2D = $Knight

var has_transformed: bool = false
var spawn_point: Vector2   

func _ready() -> void:
	spawn_point = global_position   
	inner_peace.show()
	if knight:
		knight.hide()

func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# left/right
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if Input.is_action_just_pressed("Reset"):   
		respawn()

func become_knight() -> void:
	if has_transformed:
		return
	has_transformed = true
	inner_peace.hide()
	knight.show()
	knight.play("idle")

func respawn() -> void:
	global_position = spawn_point
	velocity = Vector2.ZERO

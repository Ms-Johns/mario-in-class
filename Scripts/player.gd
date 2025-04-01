extends CharacterBody2D

# Get the gravity from project settings
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

# references
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Export Variables
@export_group("locomotion")
@export var RUN_SPEED_DAMPING = 0.5
@export var SPEED = 200
@export var JUMP_VELOCITY = -350
@export_group("")

@export_group("camera_sync")
@export var camera_sync: Camera2D
@export var should_camera_sync: bool = true
@export_group("")

func _physics_process(delta: float) -> void:
	
	# handle camera
	var camera_left_bound = camera_sync.global_position.x - camera_sync.get_viewport_rect().size.x / 2 / camera_sync.zoom.x
	
	if global_position.x < camera_left_bound + 8 && sign(velocity.x) == -1:
		velocity.x = 0
		return
	
	# Handle Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
	
	# Handle left/right running
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = lerpf(velocity.x, SPEED * direction, RUN_SPEED_DAMPING * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	
	animated_sprite_2d.trigger_animation(velocity,direction)
	
	move_and_slide()

func _process(delta: float) -> void:
	if global_position.x > camera_sync.global_position.x && should_camera_sync:
		camera_sync.global_position.x = global_position.x

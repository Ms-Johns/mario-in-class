extends Area2D

class_name Enemy

# initialising variables
@export var HORIZONTAL_SPEED = 20
@export var VERTICAL_SPEED = 100
@export var DIRECTION = 1

# On ready
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var forwards: RayCast2D = $Forwards


func _physics_process(delta: float) -> void:
	position.x -= delta * HORIZONTAL_SPEED * DIRECTION
	
	if !ray_cast_2d.is_colliding():
		position.y += delta * VERTICAL_SPEED
		
	if forwards.is_colliding():
		DIRECTION *= -1
		forwards.rotate(deg_to_rad(180))


func die():
	HORIZONTAL_SPEED = 0
	VERTICAL_SPEED = 0
	animated_sprite_2d.play("dead")

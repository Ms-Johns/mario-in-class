extends Area2D

class_name Enemy

# initialising variables
@export var HORIZONTAL_SPEED = 20
@export var VERTICAL_SPEED = 100

# On ready
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D


func _physics_process(delta: float) -> void:
	position.x -= delta * HORIZONTAL_SPEED
	
	if !ray_cast_2d.is_colliding():
		position.y += delta * VERTICAL_SPEED

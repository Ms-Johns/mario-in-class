extends AnimatedSprite2D

class_name PlayerAnimatedSprite

func trigger_animation(velocity: Vector2, direction: int):
	
	#animate jumps
	if not get_parent().is_on_floor():
		play("small_jump")
	
	#animate slide
	elif sign(velocity.x) != sign(direction) && velocity.x != 0 && direction != 0:
		play("small_slide")
		scale.x = direction
	
	else:
		# handle sprite direction
		if scale.x == 1 && sign(velocity.x) == -1:
			scale.x = -1
		elif scale.x == -1 && sign(velocity.x) == 1:
			scale.x = 1
		
		#animate run and idle
		if velocity.x != 0:
			play("small_run")
		else:
			play("small_idle")

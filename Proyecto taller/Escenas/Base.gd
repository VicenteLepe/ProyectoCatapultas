extends RigidBody2D

func _physics_process(delta):
	if Input.is_key_pressed(KEY_D):
		set_linear_velocity(Vector2(200, 0))
	elif Input.is_key_pressed(KEY_A):
		set_linear_velocity(Vector2(-200, 0))
	else: 
		set_linear_velocity(Vector2())



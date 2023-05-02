extends RigidBody2D

func _physics_process(_delta):
	if Input.is_key_pressed(KEY_RIGHT):
		set_linear_velocity(Vector2(150, get_linear_velocity().y))
	elif Input.is_key_pressed(KEY_LEFT):
		set_linear_velocity(Vector2(-150, get_linear_velocity().y))
	else:
		set_linear_velocity(Vector2((get_linear_velocity().x - get_linear_velocity().x * 0.05), get_linear_velocity().y))

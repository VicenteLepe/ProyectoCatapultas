extends RigidBody2D

var player = ""

func _physics_process(_delta):
	if player == "":
		return
	var move_right = "move_right_"+player
	if Input.is_action_pressed(move_right):
		set_linear_velocity(Vector2(150, get_linear_velocity().y))
	elif Input.is_key_pressed(KEY_A):
		set_linear_velocity(Vector2(-150, get_linear_velocity().y))
	else:
		set_linear_velocity(Vector2((get_linear_velocity().x - get_linear_velocity().x * 0.05), get_linear_velocity().y))

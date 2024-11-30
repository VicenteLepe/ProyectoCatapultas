extends Camera2D

func _physics_process(_delta):
	if not Game.cam_A or not Game.cam_B:
		return
	global_position = (Game.cam_A.global_position + Game.cam_B.global_position)/2
	var distance = Game.cam_A.global_position.distance_to(Game.cam_B.global_position)
	var initial_distance = 900
	if (Vector2.ONE * 0.5 * initial_distance/distance) < (Vector2.ONE * 0.5):
		zoom = Vector2.ONE * 0.5 * initial_distance/distance
	else:
		zoom = Vector2.ONE * 0.5

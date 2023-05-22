extends Camera2D

func _physics_process(delta):
	if not Game.player_A or not Game.player_B:
		return
	global_position = (Game.player_A.global_position + Game.player_B.global_position)/2
	var distance = Game.player_A.global_position.distance_to(Game.player_B.global_position)
	var initial_distance = 900
	if (Vector2.ONE * 0.5 * initial_distance/distance) < (Vector2.ONE * 0.5):
		zoom = Vector2.ONE * 0.5 * initial_distance/distance
	else:
		zoom = Vector2.ONE * 0.5

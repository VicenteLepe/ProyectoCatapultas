extends Camera2D

func _physics_process(delta):
	if not Game.player_A or not Game.player_B:
		return
	global_position = (Game.player_A.global_position + Game.player_B.global_position)/2

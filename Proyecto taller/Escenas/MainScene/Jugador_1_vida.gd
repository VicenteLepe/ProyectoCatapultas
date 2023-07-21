extends MarginContainer

@onready var jugador_1_vida = $"."
@onready var progress_bar = $ProgressBar
@onready var victory_menu_2 = $"../../CanvasLayer2/Victory_menu2"

func _physics_process(delta):
	
	global_position = (Game.cam_A.global_position + Game.cam_B.global_position)/2
	var distance = Game.cam_A.global_position.distance_to(Game.cam_B.global_position)
	var initial_distance = 900
	if (Vector2.ONE * 0.5 * initial_distance/distance) < (Vector2.ONE * 0.5):
		jugador_1_vida.position = Vector2(-630,-420) + Vector2.ONE * initial_distance/distance
	else:
		jugador_1_vida.position = Vector2(-630,-420)
	
	
	
	progress_bar.value = Game.player_1_health
	
	if Game.player_1_health<=0 :
		await get_tree().create_timer(0.5).timeout
		victory_menu_2.visible =true
	



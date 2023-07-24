extends MarginContainer

@onready var jugador_1_vida = $"."
@onready var progress_bar = $ProgressBar
@onready var victory_menu_2 = $"../../CanvasLayer2/Victory_menu2"
@onready var camera = $".."
@onready var autobuilder = $"../../Autobuilder"


func _physics_process(delta):
	
	jugador_1_vida.position = Vector2(-610,-420) - Vector2(1200,1400) * (1/(camera.zoom.x *4)-0.5)
	scale = Vector2(1.5, 1.5) + Vector2(2.75, 2.75) * (1/(camera.zoom.x *4)-0.5)

	progress_bar.value = Game.player_1_health
	
	if Game.player_1_health<=0 :
		await get_tree().create_timer(0.5).timeout
		victory_menu_2.visible =true
		print(autobuilder.intersections)
	



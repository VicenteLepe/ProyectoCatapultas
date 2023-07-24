extends MarginContainer

@onready var jugador_2_vida = $"."
@onready var progress_bar = $ProgressBar
@onready var victory_menu = $"../../CanvasLayer2/Victory_menu"
@onready var camera = $".."

func _physics_process(delta):
	
	jugador_2_vida.position = Vector2(380,-420) + Vector2(800,-1400) * (1/(camera.zoom.x *4)-0.5)
	scale = Vector2(1.5, 1.5) + Vector2(2.75, 2.75) * (1/(camera.zoom.x *4)-0.5)
	
	progress_bar.value = Game.player_2_health
	
	if Game.player_2_health<=0 :
		await get_tree().create_timer(0.5).timeout
		victory_menu.visible =true


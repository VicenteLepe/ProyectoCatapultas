extends MarginContainer

@onready var boton_start = %BotonStart
@onready var boton_exit = %BotonExit
@onready var boton_credits = %Credits
@onready var boton_how_to_play = %"How-to-play"



func _ready():
	get_tree().paused = false
	boton_start.pressed.connect(_on_start_pressed)
	boton_exit.pressed.connect(_on_exit_pressed)
	boton_credits.pressed.connect(_on_credits_pressed)
	boton_how_to_play.pressed.connect(_on_how_to_play_pressed)
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Escenas/BuildingScenes/PlayerBuilding.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
	
func _on_how_to_play_pressed():
	print("hay que implementar esta escena")
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/credits.tscn")

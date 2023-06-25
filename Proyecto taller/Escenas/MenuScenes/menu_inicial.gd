extends MarginContainer

@onready var boton_start = %BotonStart
@onready var boton_exit = %BotonExit
@onready var boton_credits = %Credits
@onready var boton_information = %Information



func _ready():
	get_tree().paused = false
	boton_start.pressed.connect(_on_start_pressed)
	boton_exit.pressed.connect(_on_exit_pressed)
	boton_credits.pressed.connect(_on_credits_pressed)
	boton_information.pressed.connect(_on_information_pressed)
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Escenas/BuildingScenes/PlayerBuilding.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
	
func _on_information_pressed():
	print("hay que implementar esta escena")
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/credits.tscn")

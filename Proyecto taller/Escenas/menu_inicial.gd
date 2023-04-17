extends MarginContainer

@onready var boton_start = %BotonStart
@onready var boton_exit = %BotonExit
@onready var boton_credits = %Credits


func _ready():
	boton_start.pressed.connect(_on_start_pressed)
	boton_exit.pressed.connect(_on_exit_pressed)
	boton_credits.pressed.connect(_on_credits_pressed)
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Escenas/PlayerBuilding.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Escenas/credits.tscn")

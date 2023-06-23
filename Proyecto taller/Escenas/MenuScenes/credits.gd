extends Node2D
func _ready():
	get_tree().paused = false
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/menu_inicial.tscn")

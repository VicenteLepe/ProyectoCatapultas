extends MarginContainer
@onready var main = %Main
@onready var rematch = %Rematch


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	main.pressed.connect(_on_main_pressed)
	rematch.pressed.connect(_on_rematch_pressed)
	hide()


func _on_rematch_pressed():
	get_tree().reload_current_scene()


func _on_main_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/menu_inicial.tscn")
	get_tree().paused = false

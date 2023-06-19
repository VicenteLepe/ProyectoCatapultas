extends MarginContainer

@onready var resume = %Resume
@onready var main = %Main
@onready var exit = %Exit



func _ready():
	get_tree().paused = false
	resume.pressed.connect(_on_resume_pressed)
	main.pressed.connect(_on_main_pressed)
	exit.pressed.connect(_on_exit_pressed)
	hide()

func _input(event):
	if event.is_action_pressed("pause"):
		show()
		get_tree().paused = true
		
func _on_resume_pressed():
	hide()
	get_tree().paused = false
	
func _on_main_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/menu_inicial.tscn")
	get_tree().paused = false
	
func _on_exit_pressed():
	get_tree().quit()

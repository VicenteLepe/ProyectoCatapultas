extends MarginContainer

@onready var boton_start = %BotonStart
@onready var boton_exit = %BotonExit
@export var main_scene: PackedScene
func _ready():
	boton_start.pressed.connect(_on_start_pressed)
	boton_exit.pressed.connect(_on_exit_pressed)
func _on_start_pressed():
	get_tree().change_scene_to_packed(main_scene)
	
func _on_exit_pressed():
	get_tree().quit()

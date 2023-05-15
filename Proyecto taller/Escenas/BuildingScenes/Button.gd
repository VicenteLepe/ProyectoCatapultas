extends Button
@onready var continuar = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
		if continuar.ACTION_MODE_BUTTON_PRESS = true:
			get_tree().change_scene_to_file("res://Escenas/MainScene/Main.tscn")


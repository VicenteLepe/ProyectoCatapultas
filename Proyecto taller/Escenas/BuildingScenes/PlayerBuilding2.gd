extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var label = $AnimationPlayer/Label

func _ready():
	animation_player.play("animation_label")
	
func hide_label():
	label.hide()
func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

func _on_to_player_1_pressed():
	get_tree().change_scene_to_file("res://Escenas/BuildingScenes/PlayerBuilding.tscn")


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Escenas/MainScene/Main.tscn")

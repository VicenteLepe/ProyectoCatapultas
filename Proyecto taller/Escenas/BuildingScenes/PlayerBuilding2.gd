extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var label = $AnimationPlayer/Label
@onready var animation_player_2 = $AnimationPlayer2
@onready var player_2 = $"AnimationPlayer2/Player 2"

func _ready():
	animation_player.play("animation_label")
	animation_player_2.play("player_2")
func hide_label():
	label.hide()
func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

func _on_to_player_1_pressed():
	get_tree().change_scene_to_file("res://Escenas/BuildingScenes/PlayerBuilding.tscn")


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Escenas/MainScene/Main.tscn")

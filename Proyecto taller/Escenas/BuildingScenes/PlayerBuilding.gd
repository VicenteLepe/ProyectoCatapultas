extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var label = $AnimationPlayer/Label
@onready var animation_player_segundo = $AnimationPlayer_segundo
@onready var player_1 = $"AnimationPlayer_segundo/Player 1"

func _ready():
	animation_player.play("animation_label")
	animation_player_segundo.play(("player_1"))
func hide_label():
	label.hide()
func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	
func _on_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/menu_inicial.tscn")


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Escenas/BuildingScenes/PlayerBuilding2.tscn")

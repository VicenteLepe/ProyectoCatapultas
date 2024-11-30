extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var margin_container = $"."

func _ready():
	get_tree().paused = false
	animation_player.play("animation_credit_scene")

func _on_returnmainmenu_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/menu_inicial.tscn")

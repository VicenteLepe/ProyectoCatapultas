extends Node2D

@export var elements : Dictionary
@export var intersections : Dictionary

var building_base_scene = preload("res://Escenas/BuildingScenes/building_base.tscn")
var building_plank_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")
var building_wheel_scene = preload("res://Escenas/BuildingScenes/building_wheel.tscn")
var building_bucket_scene = preload("res://Escenas/BuildingScenes/building_bucket.tscn")

var test_dictionary = preload("res://Escenas/test_dictionary.tscn")

var test_a = test_dictionary.instantiate()
var test = test_a.get_node("Node")




func _ready():

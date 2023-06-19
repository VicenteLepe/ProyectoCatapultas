extends Builder

var building_object_scene
var object_type
@onready var base_builder = $Base_Builder
@onready var plank_builder = $Plank_Builder
@onready var wheel_builder = $Wheel_Builder

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	# Get a reference to the parent node script
	Building_node = get_parent()
	base_builder.Building_node = Building_node
	plank_builder.Building_node = Building_node
	wheel_builder.Building_node = Building_node


func _unhandled_input(event):
	if Building_node.base_building_state:
		building_state = Building_node.base_building_state
		building_object_scene = preload("res://Escenas/BuildingScenes/building_base.tscn")
		object_type = "Base "
		
	if Building_node.plank_building_state:
		building_state = Building_node.plank_building_state
		building_object_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")	
		object_type = "Plank "

	if Building_node.wheel_building_state:
		building_state = Building_node.wheel_building_state
		building_object_scene = preload("res://Escenas/BuildingScenes/building_wheel.tscn")
		object_type = "Wheel "
		
	if building_state:
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var click_pos = get_local_mouse_position()
				if object_type == "Base ":
					base_builder.build_object(building_object_scene, object_type, click_pos)
				if object_type == "Plank ":
					plank_builder.build_object(building_object_scene, object_type, click_pos)
				if object_type == "Wheel ":
					wheel_builder.build_object(building_object_scene, object_type, click_pos)

	if event is InputEventKey and event.keycode == KEY_P and event.pressed:
		get_tree().paused = not get_tree().paused


# Function to get the object list
func get_object_list():
	return list

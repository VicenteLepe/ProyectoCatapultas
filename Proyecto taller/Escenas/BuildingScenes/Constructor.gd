extends Builder
class_name Physics2DServer
var building_element_scene
var element_type
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
		building_element_scene = preload("res://Escenas/BuildingScenes/building_base.tscn")
		element_type = "Base"
		
	if Building_node.plank_building_state:
		building_state = Building_node.plank_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")	
		element_type = "Plank"

	if Building_node.wheel_building_state:
		building_state = Building_node.wheel_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_wheel.tscn")
		element_type = "Wheel"


	if building_state:
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var click_pos = get_local_mouse_position()
				if element_type == "Base":
					base_builder.build_element(building_element_scene, element_type, click_pos)
				if element_type == "Plank":
					plank_builder.build_element(building_element_scene, element_type, click_pos)
				if element_type == "Wheel":
					wheel_builder.build_element(building_element_scene, element_type, click_pos)

	if event is InputEventKey and event.keycode == KEY_P and event.pressed:
		get_tree().paused = not get_tree().paused

	if event is InputEventKey and event.keycode == KEY_X and event.pressed:
		Building_node.populate_intersection_dict(Building_node.building_element_dict)
		Building_node.create_pinjoints(Building_node.building_intersection_dict)
		Building_node.check_wheels(Building_node.building_element_dict)

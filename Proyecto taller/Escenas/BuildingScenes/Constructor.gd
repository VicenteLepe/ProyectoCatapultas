extends Builder

var building_object_scene
var object_type
var plank_builder = Plank_builder.new()
var wheel_builder = Wheel_builder.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get a reference to the parent node script
	Building_node = get_parent()


func _unhandled_input(event):
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
				if object_type == "Plank ":
					plank_builder.build_object(building_object_scene, object_type, click_pos)
				if object_type == "Wheel ":
					plank_builder.build_object(building_object_scene, object_type, click_pos)
				

		if event is InputEventKey and event.keycode == KEY_P and event.pressed:
			for object in list:
				var object_node = object[2]
				if object_node.freeze == false:
					object_node.freeze = true
				else:
					object_node.freeze = false


# Function to get the object list
func get_object_list():
	return list

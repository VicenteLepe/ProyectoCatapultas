extends Builder
class_name Physics2DServer1
var building_element_scene
var element_type
@onready var base_builder = $Base_Builder
@onready var plank_builder = $Plank_Builder
@onready var wheel_builder = $Wheel_Builder
@onready var rope_builder = $Rope_Builder
@onready var bucket_builder_1 = $Bucket_Builder1


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	# Get a reference to the parent node script
	Building_node = get_parent()
	base_builder.Building_node = Building_node
	plank_builder.Building_node = Building_node
	wheel_builder.Building_node = Building_node
	bucket_builder_1.Building_node = Building_node
	rope_builder.Building_node = Building_node


func _unhandled_input(event):
	if Building_node.base_building_state  and element_type != "Base":
		building_state = Building_node.base_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_base.tscn")
		element_type = "Base"
		
	if Building_node.plank_building_state  and element_type != "Plank":
		building_state = Building_node.plank_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")	
		element_type = "Plank"

	if Building_node.wheel_building_state  and element_type != "Wheel":
		building_state = Building_node.wheel_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_wheel.tscn")
		element_type = "Wheel"
		
	if Building_node.bucket_building_state  and element_type != "Bucket":
		building_state = Building_node.bucket_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_bucket.tscn")
		element_type = "Bucket"
		
	if Building_node.rope_building_state and element_type != "Rope":
		building_state = Building_node.rope_building_state
		building_element_scene = preload("res://Escenas/BuildingScenes/building_rope.tscn")
		element_type = "Rope"
		Game.positions_dict = {}
		if "Base" in Building_node.building_element_dict:
			for base in Building_node.building_element_dict["Base"]:
				var positions = base["element_positions"]
				if positions[0] not in Game.positions_dict:
					Game.positions_dict[positions[0]] = base["element_node"]
				if positions[1] not in Game.positions_dict:
					Game.positions_dict[positions[1]] = base["element_node"]
		
		if "Bucket" in Building_node.building_element_dict:
			for bucket in Building_node.building_element_dict["Bucket"]:
				var positions = bucket["element_positions"]
				if positions[0] not in Game.positions_dict:
					Game.positions_dict[positions[0]] = bucket["element_node"]
				if positions[1] not in Game.positions_dict:
					Game.positions_dict[positions[1]] = bucket["element_node"]
		
		if "Plank" in Building_node.building_element_dict:
			for plank in Building_node.building_element_dict["Plank"]:
				var positions = plank["element_positions"]
				if positions[0] not in Game.positions_dict:
					Game.positions_dict[positions[0]] = plank["element_node"]
				if positions[1] not in Game.positions_dict:
					Game.positions_dict[positions[1]] = plank["element_node"]
		#To Do
		var positions = Game.positions_dict.keys()
		
			


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
				if element_type == "Bucket":
					bucket_builder_1.build_element(building_element_scene, element_type, click_pos)
				if element_type == "Rope":
					rope_builder.build_element(building_element_scene, element_type, click_pos)


	if event is InputEventKey and event.keycode == KEY_P and event.pressed:
		Building_node.populate_intersection_dict(Building_node.building_element_dict)
		Building_node.create_pinjoints(Building_node.building_intersection_dict)
		Building_node.check_wheels(Building_node.building_element_dict)
		get_tree().paused = not get_tree().paused

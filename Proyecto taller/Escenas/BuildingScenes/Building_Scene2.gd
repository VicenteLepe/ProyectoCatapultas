extends Node2D

@onready var select_element_button = $"../Camera2D/UI/Select_element_button"
@onready var Builder = $Constructor


var base_building_state = false
var plank_building_state = false
var wheel_building_state = false
var rope_building_state = false
var bucket_building_state = false
var delete_building_state = false

var building_element_dict = {}
var building_intersection_dict = {}

enum PlayerType {
	A, 
	B
}

@export var player: PlayerType

# esto al poner el boton continue
# tenemos que poner Game.building_element_dict_A = building_element_dict
func _input(event):
	if event.is_action_pressed("save"):
		save_data_player2()
func _ready():
	match player:
		PlayerType.A:
#			Game.player_A = base
			Game.player = "A"
		PlayerType.B:
#			Game.player_B = base
			Game.player = "B"


func _on_select_element_button_item_selected(_index):
	plank_building_state = false
	wheel_building_state = false
	rope_building_state = false
	bucket_building_state = false
	base_building_state = false

	if select_element_button.get_selected_id() == 1:
		plank_building_state = true
	elif select_element_button.get_selected_id() == 2:
		wheel_building_state = true
	elif select_element_button.get_selected_id() == 3:
		rope_building_state = true
	elif select_element_button.get_selected_id() == 4:
		bucket_building_state = true
	elif select_element_button.get_selected_id() == 5:
		base_building_state = true

func populate_intersection_dict(building_element_dict):
	#importante actualizar el element_node, porque al cambiar de escena seran nulos
	# cambiar por Game.building_element_dict 
	#building_intesection_dict = {} y al final return building_intesection_dict
	# Populate the building_intersection_dict, excluding positions with a count of 1
	for element_type in building_element_dict:
		for element in building_element_dict[element_type]:
			var element_id = element["element_id"]
			var positions = element["element_positions"]
			var element_node = element["element_node"] 
#			if element_type == "Wheel ":
#					positions = element["element_positions"][0]

			for position in positions:
				if position not in building_intersection_dict:
					building_intersection_dict[position] = []
				var exists = false
				for item in building_intersection_dict[position]:
					if item["element_type"] == element_type and item["element_id"] == element_id:
						exists = true
						break
					
				if not exists:
					building_intersection_dict[position].append({
						"element_type": element_type,
						"element_id": element_id,
						"element_node": element_node
					})
	for position in building_intersection_dict.keys():
		if len(building_intersection_dict[position])==1:
			building_intersection_dict.erase(position)

func add_to_element_dict(element, element_type):
	if element_type not in building_element_dict:
		building_element_dict[element_type] = []
	if element not in building_element_dict[element_type]:
		var element_id = element[0]
		var element_positions = element[1]
		var element_node = element[2]
		building_element_dict[element_type].append({
					"element_id": element_id,
					"element_positions": element_positions,
					"element_node": element_node
				})
func remove_element_from_dict(id, element_type):
	var index = -1
	for i in building_element_dict[element_type].size():
		if building_element_dict[element_type][i].element_id == id:
			index=i
			break
	if index>= 0:
		building_element_dict[element_type].remove_at(index)
		
func create_pinjoints(building_intersection_dict):
	for position in building_intersection_dict:
		var element_count = len(building_intersection_dict[position])
		for i in range(element_count - 1):
			for j in range(i + 1, element_count):
				var first_element = building_intersection_dict[position][i]["element_node"]
				var second_element = building_intersection_dict[position][j]["element_node"]

				var pin_joint = PinJoint2D.new()
				pin_joint.node_a = first_element.get_path()
				pin_joint.node_b = second_element.get_path()
				pin_joint.softness = 0
				pin_joint.position = position
				pin_joint.disable_collision = true
				add_child(pin_joint)

func check_wheels(building_element_dict):
	if "Wheel" in building_element_dict and building_element_dict.Wheel.size():
		if "Base" in building_element_dict:
			for base_dict in building_element_dict.Base:
				base_dict.element_node.has_wheels = true
	
func save_data_player2():
	var file = FileAccess.open("user://data_player2.json", FileAccess.WRITE)
	file.store_var(building_element_dict)


func _on_continue_button_pressed():
	save_data_player2()
extends Node2D

@onready var select_element_button = $"../Camera2D/UI/Select_element_button"
@onready var Builder = $Constructor


var base_building_state = false
var plank_building_state = false
var wheel_building_state = false
var cable_building_state = false
var bucket_building_state = false

var building_element_dict = {}
var building_intersection_dict = {}

class building_element:
	var elementType: String
	var id: int

	func _init(elementType: String, id: int):
		self.elementType = elementType
		self.id = id

func _on_select_element_button_item_selected(_index):
	plank_building_state = false
	wheel_building_state = false
	cable_building_state = false
	bucket_building_state = false
	base_building_state = false

	if select_element_button.get_selected_id() == 1:
		plank_building_state = true
	elif select_element_button.get_selected_id() == 2:
		wheel_building_state = true
	elif select_element_button.get_selected_id() == 3:
		cable_building_state = true
	elif select_element_button.get_selected_id() == 4:
		bucket_building_state = true
	elif select_element_button.get_selected_id() == 5:
		base_building_state = true

func add_to_intersection_dict(element, position):
	if element not in building_intersection_dict[position]:
		building_intersection_dict[position].append
func add_position_to_intersection_dict(position):
	if position not in building_intersection_dict:
		building_intersection_dict[position]=[]

func _ready():
	var list = Builder.get_object_list()
	building_element_dict["all"] = list


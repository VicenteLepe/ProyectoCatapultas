extends Node2D

var building_plank_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")
var start_pos = null
var grid_size = 32

var plank_list = []
var plank_id = 0

var Building_node

func _ready():
	# Get a reference to the parent node script
	Building_node = get_parent()

func _unhandled_input(event):
	var plank_building_state = Building_node.plank_building_state
	if Building_node.plank_building_state:
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var click_pos = get_local_mouse_position()
				for plank in plank_list:
					var plank_start = plank[1][0]
					var plank_end = plank[1][1]
					var snapped_pos = snapped(click_pos, Vector2(grid_size, grid_size))
					if snapped_pos.distance_to(plank_start) < 5 or snapped_pos.distance_to(plank_end) < 5:
						if snapped_pos not in Building_node.building_intersection_dict:
							Building_node.add_position_to_intersection_dict(snapped_pos)
						break
				if start_pos == null:
					# first click, record start position
					start_pos = get_local_mouse_position()
					start_pos = snapped(start_pos, Vector2(grid_size, grid_size))
				else:
					# second click, create construction plank
					var end_pos = get_local_mouse_position()
					end_pos = snapped(end_pos, Vector2(grid_size, grid_size))
					if end_pos == start_pos:
						# don't create plank if start and end positions are the same
						return
					var building_plank = building_plank_scene.instantiate()
					building_plank.position = (start_pos + end_pos) / 2
					building_plank.rotation = (end_pos - start_pos).angle()
					var rigidbody = building_plank.get_node_or_null("RigidBody2D")
	#				if rigidbody:
	#					rigidbody.collision_layer = 2
	#					rigidbody.collision_mask = 1
					if rigidbody:
						var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
						if collision_shape:
							var length = (end_pos - start_pos).length()
							var collision_shape_length = collision_shape.shape.extents.x * 2
							var scale_factor = length / collision_shape_length
							collision_shape.scale.x = scale_factor
							var sprite = rigidbody.get_child(1) # assuming sprite is the second child
							if sprite:
								sprite.scale.x = scale_factor
					add_child(building_plank)
					plank_list.append([plank_id, [start_pos, end_pos], building_plank.get_child(0)])
					plank_id += 1

					for intersection in Building_node.building_intersection_dict.keys():
						var planks_in_intersection = Building_node.building_intersection_dict[intersection]
						for plank in plank_list:
							var id = plank[0]
							var start = plank[1][0]
							var end = plank[1][1]
							if intersection in [start, end]:
								if id not in planks_in_intersection:
									var new_intersecting_plank = Building_node.building_element.new("plank",id)
									planks_in_intersection.append(new_intersecting_plank)
								else:
									# Plank ID already in list, do nothing
									pass
						# Update intersection list with new plank IDs (if any)
						Building_node.building_intersection_dict[intersection] = planks_in_intersection

					start_pos = null
					for plank in plank_list:
						print("Plank ",plank[0]," at: ",plank[1])

					for intersection in Building_node.building_intersection_dict.keys():
						var intersection_elements = Building_node.building_intersection_dict[intersection]

						var elements_dict = {}
						for element in intersection_elements:
							if element.elementType not in elements_dict:
								elements_dict[element.elementType] = []
							# Check if id is not already in list before appending
							if element.id not in elements_dict[element.elementType]:
								elements_dict[element.elementType].append(element.id)

						for elementType in elements_dict.keys():
							print("Intersection at: ", intersection, " between ", elementType, " IDs ", elements_dict[elementType])

					for intersection in Building_node.building_intersection_dict.keys():
						var intersecting_planks = []
						for element in Building_node.building_intersection_dict[intersection]:
							if element.elementType == "plank":  # check if the element is a Plank
								intersecting_planks.append(element.id)
						var plank_count = intersecting_planks.size()

						# Iterate over all pairs of intersecting planks
						for i in range(plank_count - 1):
							for j in range(i + 1, plank_count):
								var first_plank = plank_list[intersecting_planks[i]][2]
								var second_plank = plank_list[intersecting_planks[j]][2]

								var pin_joint = PinJoint2D.new()
								pin_joint.node_a = first_plank.get_path()
								pin_joint.node_b = second_plank.get_path()
								pin_joint.softness = 0
								pin_joint.position = intersection
								pin_joint.disable_collision = true
								add_child(pin_joint)

		if event is InputEventKey and event.keycode == KEY_P and event.pressed:
			for plank in plank_list:
				var plank_node = plank[2]
				if plank_node.freeze == false:
					plank_node.freeze = true
				else:
					plank_node.freeze = false

# Function to get the plank list
func get_plank_list():
	return plank_list

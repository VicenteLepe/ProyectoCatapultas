extends Node2D

var building_state = false
var building_object_scene
var object_type = ""
var start_pos = null
var grid_size = 32
var list = []
var id = 0
var Building_node

func _ready():
	# Get a reference to the parent node script
	Building_node = get_parent()


func build_object(building_object_scene, object_type, click_pos):
	for object in list:
		var start = object[1][0]
		var end = object[1][1]
		var snapped_pos = snapped(click_pos, Vector2(grid_size, grid_size))
		if snapped_pos.distance_to(start) < 5 or snapped_pos.distance_to(end) < 5:
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
		var building_object = building_object_scene.instantiate()
		building_object.position = (start_pos + end_pos) / 2
		building_object.rotation = (end_pos - start_pos).angle()
		var rigidbody = building_object.get_node_or_null("RigidBody2D")
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
		add_child(building_object)
		list.append([id, [start_pos, end_pos], building_object.get_child(0)])
		id += 1

		for intersection in Building_node.building_intersection_dict.keys():
			var objects_in_intersection = Building_node.building_intersection_dict[intersection]
			for object in list:
				var id = object[0]
				var start = object[1][0]
				var end = object[1][1]
				if intersection in [start, end]:
					if id not in objects_in_intersection:
						var new_intersecting_objects = Building_node.building_element.new(object_type,id)
						objects_in_intersection.append(new_intersecting_objects)
					else:
						# Plank ID already in list, do nothing
						pass
			# Update intersection list with new plank IDs (if any)
			Building_node.building_intersection_dict[intersection] = objects_in_intersection

		start_pos = null
		for object in list:
			print(object_type,object[0]," at: ",object[1])

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
			var intersecting_objects = []
			for element in Building_node.building_intersection_dict[intersection]:
				if element.elementType == object_type:  
					intersecting_objects.append(element.id)
			var object_count = intersecting_objects.size()

			# Iterate over all pairs of intersecting planks
			for i in range(object_count - 1):
				for j in range(i + 1, object_count):
					var first_object = list[intersecting_objects[i]][2]
					var second_object = list[intersecting_objects[j]][2]

					var pin_joint = PinJoint2D.new()
					pin_joint.node_a = first_object.get_path()
					pin_joint.node_b = second_object.get_path()
					pin_joint.softness = 0
					pin_joint.position = intersection
					pin_joint.disable_collision = true
					add_child(pin_joint)

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
				build_object(building_object_scene, object_type, click_pos)
				

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

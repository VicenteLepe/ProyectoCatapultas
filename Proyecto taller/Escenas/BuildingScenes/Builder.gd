extends Node2D

class_name Builder

var building_state = false
var start_pos = null
var grid_size = 32
var list = []
var id = 0
var Building_node

func define_object_shape(_end_pos, _start_pos, _building_object, _rigidbody, _collision_shape, _sprite):
	pass

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
		# second click, create object
		var end_pos = get_local_mouse_position()
		end_pos = snapped(end_pos, Vector2(grid_size, grid_size))
		if end_pos == start_pos:
			# don't create object if start and end positions are the same
			return
		var building_object = building_object_scene.instantiate()
		var rigidbody = building_object.get_node_or_null("RigidBody2D")
		var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
		var sprite = rigidbody.get_child(1) # assuming sprite is the second child
		
		define_object_shape(end_pos, start_pos, building_object, rigidbody, collision_shape, sprite)
			
			
		add_child(building_object)
		list.append([id, [start_pos, end_pos], building_object.get_child(0)])
		id += 1

		for intersection in Building_node.building_intersection_dict.keys():
			var objects_in_intersection = Building_node.building_intersection_dict[intersection]
			for object in list:
				id = object[0]
				var start = object[1][0]
				var end = object[1][1]
				if intersection in [start, end]:
					if id not in objects_in_intersection:
						var new_intersecting_objects = Building_node.building_element.new(object_type,id)
						objects_in_intersection.append(new_intersecting_objects)
					else:
						# object ID already in list, do nothing
						pass
			# Update intersection list with new object IDs (if any)
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

			# Iterate over all pairs of intersecting objects
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


# Function to get the object list
func get_object_list():
	return list

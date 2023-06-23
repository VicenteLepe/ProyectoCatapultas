extends Node2D

class_name Builder

var building_state = false
var start_pos = null
var grid_size = 32
var list = []
var id = 0
var Building_node

func define_element_shape(_end_pos, _start_pos, _building_element, _rigidbody, _collision_shape, _sprite):
	pass

func build_element(building_element_scene, element_type, click_pos):
	# this code check if a base exists,and if it does, it does not create another one.
	var x=0
	if element_type == "Base ":
		for element in list:
			print("elemento2:",element[-1])
			if element[-1] == "Base ":
				x=1
				break
	if x==1:
		return
	for element in list:
		var start = element[1][0]
		var end = element[1][1]
		var snapped_pos = snapped(click_pos, Vector2(grid_size, grid_size))
	if start_pos == null:
		# first click, record start position
		start_pos = get_local_mouse_position()
		start_pos = snapped(start_pos, Vector2(grid_size, grid_size))
	else:
		# second click, create element
		var end_pos = get_local_mouse_position()
		end_pos = snapped(end_pos, Vector2(grid_size, grid_size))
		if end_pos == start_pos:
			# don't create element if start and end positions are the same
			return
		var building_element = building_element_scene.instantiate()
		var rigidbody = building_element.get_node_or_null("RigidBody2D")
		var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
		var sprite = rigidbody.get_child(1) # assuming sprite is the second child
		
		define_element_shape(end_pos, start_pos, building_element, rigidbody, collision_shape, sprite)
		add_child(building_element)
		list.append([id, [start_pos, end_pos], building_element.get_child(0), element_type])
		id += 1
		start_pos = null

		for element in list:
			Building_node.add_to_element_dict([element[0],element[1],element[2]],element_type)



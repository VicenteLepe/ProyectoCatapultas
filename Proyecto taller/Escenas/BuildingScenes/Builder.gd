extends Node2D

class_name Builder

var building_state = false
var start_pos = null
var grid_size = 32
var list = []
var id = 0
var Building_node

var object1
var object2

func define_element_shape(_end_pos, _start_pos, _building_element, _rigidbody, _collision_shape, _sprite):
	pass
	
func define_rope_shape(_end_pos, _start_pos, _building_element, object1, object2):
	pass

func build_element(building_element_scene, element_type, click_pos):
	# this code check if a base exists,and if it does, it does not create another one.
	var x=0
	var q=0
	if element_type == "Base":
		for element in list:
			if element[-1] == "Base":
				x=1
				break
	if x==1:
		return
	if element_type == "Bucket":
		for element in list:
			if element[-1]=="Bucket":
				q=1
				break
	if q==1:
		return			
	for element in list:
		var start = element[1][0]
		var end = element[1][1]
		var snapped_pos = snapped(click_pos, Vector2(grid_size, grid_size))
	if start_pos == null:
		# first click, record start position
		start_pos = get_local_mouse_position()
		start_pos = snapped(start_pos, Vector2(grid_size, grid_size))
		if element_type == "Rope":
			if start_pos in Game.positions_dict:
				object2 = Game.positions_dict[start_pos]
			else:
				start_pos = null
				return
	else:
		# second click, create element
		var end_pos = get_local_mouse_position()
		end_pos = snapped(end_pos, Vector2(grid_size, grid_size))
		if element_type == "Rope":
			if end_pos in Game.positions_dict:
				object1 = Game.positions_dict[end_pos]
			else:
				end_pos = null
				return
		
		if end_pos == start_pos:
			# don't create element if start and end positions are the same
			return
		var building_element = building_element_scene.instantiate()
		if element_type =="Rope":
			define_rope_shape(end_pos, start_pos, building_element, object1, object2)
			add_child(building_element)
			list.append([id, [start_pos, end_pos], building_element.get_child(0), element_type])
			Building_node.add_to_element_dict([id, [start_pos, end_pos], building_element.get_child(0)],element_type)
			id += 1
			start_pos = null
		else:
			var rigidbody = building_element.get_node_or_null("RigidBody2D")
			var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
			var sprite = rigidbody.get_child(1) # assuming sprite is the second child
			
			define_element_shape(end_pos, start_pos, building_element, rigidbody, collision_shape, sprite)
			add_child(building_element)
			list.append([id, [start_pos, end_pos], building_element.get_child(0), element_type])
			if rigidbody.has_signal("delete_requested"):
				rigidbody.delete_requested.connect(_on_delete_requested.bind(building_element, id, element_type))
			Building_node.add_to_element_dict([id, [start_pos, end_pos], building_element.get_child(0)],element_type)
			id += 1
			start_pos = null
			

#		for element in list:
#			Building_node.add_to_element_dict([element[0],element[1],element[2]],element_type)

func _on_delete_requested(building_element, id, element_type):
	var index = -1
	for i in list.size():
		if list[i][0]== id:
			index=i
			break
	if index>= 0:
		list.remove_at(index)
		building_element.queue_free()
		Building_node.remove_element_from_dict(id, element_type)

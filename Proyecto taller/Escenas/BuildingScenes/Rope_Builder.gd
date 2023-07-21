extends Builder

class_name Rope_builder

func define_rope_shape(_end_pos, _start_pos, _building_element, object1, object2):		
	# define the position of the plank
	_building_element.position = (_start_pos + _end_pos) / 2
	_building_element.rotation = (_end_pos - _start_pos).angle()
	var join = _building_element.get_node_or_null("SpringRope")
	join.length = (_end_pos - _start_pos).length()
	join.position = Vector2((_end_pos - _start_pos).length()/2,0)
	join.node_a = object1.get_path()
	join.node_b = object2.get_path()
	

	# calculate the scale factor
	var length = (_end_pos - _start_pos).length()
	#var collision_shape_length = _collision_shape.shape.extents.x * 2
	#var scale_factor = length / collision_shape_length
	# scale the length of the plank
	#_collision_shape.shape.extents.x = length/2 
	#_sprite.scale.x = scale_factor
	
	_building_element.get_child(0).player = Game.player

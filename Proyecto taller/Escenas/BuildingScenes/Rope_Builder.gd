extends Builder

class_name Rope_builder

func define_element_shape(_end_pos, _start_pos, _building_element, _rigidbody, _collision_shape, _sprite):		
	# define the position of the plank
	
	_building_element.position = (_start_pos + _end_pos)/2
	_building_element.rotation = (_end_pos - _start_pos).angle()
	
	_rigidbody.position = Vector2((_end_pos - _start_pos).length()/2,0)
	
	var rope_end = _building_element.get_node_or_null("End")
	rope_end.position = -Vector2((_end_pos - _start_pos).length()/2,0)
	
	var join = _building_element.get_node_or_null("SpringRope")
	join.length = (_end_pos - _start_pos).length()
	join.position = Vector2((_end_pos - _start_pos).length()/2,0)
	

	# calculate the scale factor
	#var length = (_end_pos - _start_pos).length()
	#var collision_shape_length = _collision_shape.shape.extents.x * 2
	#var scale_factor = length / collision_shape_length
	# scale the length of the plank
	#_collision_shape.shape.extents.x = length/2 
	#_sprite.scale.x = scale_factor

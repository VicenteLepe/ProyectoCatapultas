extends Builder

class_name Bucket_builder

func define_element_shape(_end_pos, _start_pos, _building_element, _rigidbody, _collision_shape, _sprite):		
	# define the position of the plank
	
	var bucket = _building_element.get_node_or_null("Bucket")
	bucket.position = -Vector2((_end_pos - _start_pos).length()/2,0)
	
	var pinjoin = _building_element.get_node_or_null("PinJoint2D")
	pinjoin.position = -Vector2((_end_pos - _start_pos).length()/2,0)
	
	var pinjoin2 = _building_element.get_node_or_null("PinJoint2D2")
	pinjoin2.position = -Vector2(((_end_pos - _start_pos).length()/2)-10,0)
	
	_building_element.position = (_start_pos + _end_pos) / 2
	_building_element.rotation = (_end_pos - _start_pos).angle()
	# calculate the scale factor
	var length = (_end_pos - _start_pos).length()
	var collision_shape_length = _collision_shape.shape.extents.x * 2
	var scale_factor = length / collision_shape_length
	# scale the length of the plank
	_collision_shape.shape.extents.x = length/2 
	_sprite.scale.x = scale_factor

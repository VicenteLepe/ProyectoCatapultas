extends Builder

class_name Base_builder

func define_object_shape(_end_pos, _start_pos, _building_object, _rigidbody, _collision_shape, _sprite):
	# define the position of the plank
	_building_object.position = (_start_pos + _end_pos) / 2
	_building_object.rotation = (_end_pos - _start_pos).angle()
	# calculate the scale factor
	var length = (_end_pos - _start_pos).length()
	var collision_shape_length = _collision_shape.shape.extents.x * 2
	var scale_factor = length / collision_shape_length
	# scale the length of the plank
	_collision_shape.shape.extents.x = length/2 + 2
	_sprite.scale.x = scale_factor



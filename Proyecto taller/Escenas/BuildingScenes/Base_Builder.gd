extends Builder

class_name Base_builder

func define_element_shape(_end_pos, _start_pos, _building_element, _rigidbody, _collision_shape, _sprite):
	# define the position of the plank
	_building_element.position = (_start_pos + _end_pos) / 2
	_building_element.rotation = (_end_pos - _start_pos).angle()
	# calculate the scale factor
	var length = (_end_pos - _start_pos).length()
	# scale the length of the plank
	_collision_shape.shape.extents.x = length/2
	_sprite.scale.x = length/85
	
	_building_element.get_child(0).player = Game.player

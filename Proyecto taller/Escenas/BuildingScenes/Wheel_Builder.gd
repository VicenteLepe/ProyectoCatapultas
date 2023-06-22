extends Builder

class_name Wheel_builder

func define_element_shape(_end_pos, _start_pos, _building_element, _rigidbody, _collision_shape, _sprite):		
		# define the position of the wheel
		_building_element.position = _start_pos
		# calculate the scale factor
		var wheel_radius = (_end_pos - _start_pos).length()
		# scale the shape of the wheel
		_collision_shape.shape.radius = wheel_radius/2.5
		_sprite.scale.x = wheel_radius/16
		_sprite.scale.y = wheel_radius/16

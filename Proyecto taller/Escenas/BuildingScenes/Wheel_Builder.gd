extends Builder

class_name Wheel_builder

func define_object_shape(_end_pos, _start_pos, _building_object, _rigidbody, _collision_shape, _sprite):		
		# define the position of the wheel
		_building_object.position = _start_pos
		# calculate the scale factor
		var wheel_radius = (_end_pos - _start_pos).length()
		var scale_factor1 = wheel_radius/10
		var scale_factor2 = wheel_radius/16
		# scale the shape of the wheel
		_collision_shape.scale.x = scale_factor1
		_collision_shape.scale.y = scale_factor1
		_sprite.scale.x = scale_factor2
		_sprite.scale.y = scale_factor2

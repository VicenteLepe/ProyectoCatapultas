extends Builder

class_name Wheel_builder

func define_object_shape(end_pos, start_pos, building_object, rigidbody, collision_shape, sprite):		
		# define the position of the wheel
		building_object.position = start_pos
		# calculate the scale factor
		var wheel_radius = (end_pos - start_pos).length()
		var scale_factor1 = wheel_radius/10
		var scale_factor2 = wheel_radius/16
		# scale the shape of the wheel
		collision_shape.scale.x = scale_factor1
		collision_shape.scale.y = scale_factor1
		sprite.scale.x = scale_factor2
		sprite.scale.y = scale_factor2

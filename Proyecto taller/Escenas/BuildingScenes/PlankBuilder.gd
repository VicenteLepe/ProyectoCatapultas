extends Builder

class_name Plank_builder

func define_object_shape(end_pos, start_pos, building_object, rigidbody, collision_shape, sprite):
	# define the position of the plank
	building_object.position = (start_pos + end_pos) / 2
	building_object.rotation = (end_pos - start_pos).angle()
	# calculate the scale factor
	var length = (end_pos - start_pos).length()
	var collision_shape_length = collision_shape.shape.extents.x * 2
	var scale_factor = length / collision_shape_length
	# scale the length of the plank
	collision_shape.scale.x = scale_factor
	sprite.scale.x = scale_factor



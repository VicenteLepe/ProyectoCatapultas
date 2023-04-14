extends Node2D

var building_plank_scene = preload("res://Escenas/building_plank.tscn")
var start_pos = null
var grid_size = 32

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if start_pos == null:
				# first click, record start position
				start_pos = get_local_mouse_position()
				start_pos = snapped(start_pos, Vector2(grid_size, grid_size))
				print("Planca inicio:", start_pos)
			else:
				# second click, create construction plank
				var end_pos = get_local_mouse_position()
				end_pos = snapped(end_pos, Vector2(grid_size, grid_size))
				if end_pos == start_pos:
					# don't create plank if start and end positions are the same
					return
				var building_plank = building_plank_scene.instantiate()
				print("Planca final:", end_pos)
				building_plank.position = (start_pos + end_pos) / 2
				building_plank.rotation = (end_pos - start_pos).angle()
				var rigidbody = building_plank.get_node_or_null("RigidBody2D")
				if rigidbody:
					var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
					if collision_shape:
						var length = (end_pos - start_pos).length()
						var collision_shape_length = collision_shape.shape.extents.x * 2
						var scale_factor = length / collision_shape_length
						collision_shape.scale.x = scale_factor
						var sprite = rigidbody.get_child(1) # assuming sprite is the second child
						if sprite:
							sprite.scale.x = scale_factor
				add_child(building_plank)
				start_pos = null

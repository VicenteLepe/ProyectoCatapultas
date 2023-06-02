extends Node2D

var building_wheel_scene = preload("res://Escenas/BuildingScenes/building_wheel.tscn")
var start_pos = null
var grid_size = 32

var wheel_list = []
var wheel_id = 0

var Building_node

func _ready():
	# Get a reference to the parent node script
	Building_node = get_parent()

func _unhandled_input(event):
	var wheel_building_state = Building_node.wheel_building_state
	if Building_node.wheel_building_state:
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var click_pos = get_local_mouse_position()
				var snapped_pos = snapped(click_pos, Vector2(grid_size, grid_size))
				if start_pos == null:
					# first click, record center position
					start_pos = snapped_pos
				else:
					# second click, create construction wheel
					var end_pos = snapped_pos
					if end_pos == start_pos:
						# don't create wheel if start and end positions are the same
						return
					var wheel_radius = end_pos.distance_to(start_pos)

					# Instantiate wheel scene here
					var building_wheel = building_wheel_scene.instantiate()
					building_wheel.position = start_pos
					var rigidbody = building_wheel.get_node_or_null("RigidBody2D")
	#				if rigidbody:
	#					rigidbody.collision_layer = 2
	#					rigidbody.collision_mask = 1
					if rigidbody:
						var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
					# Assuming the wheel's CollisionShape2D node has a CircleShape2D assigned to it
						if collision_shape and collision_shape.shape:
							collision_shape.shape.radius = wheel_radius/2.5
							print(collision_shape.shape.radius)
							var scale_factor = wheel_radius/16

							var sprite = rigidbody.get_child(1) # assuming sprite is the second child
							if sprite:
								sprite.scale.x = scale_factor
								sprite.scale.y = scale_factor

					add_child(building_wheel)
					wheel_list.append([wheel_id, [start_pos, wheel_radius], building_wheel.get_child(0)])
					wheel_id += 1
					start_pos = null
					# Add wheel to intersection dict if 
					if start_pos not in Building_node.building_intersection_dict:
						Building_node.add_position_to_intersection_dict(start_pos)
					# Add new wheel to intersection list
					var new_intersecting_wheel = Building_node.building_element.new("Wheel", wheel_id)
					Building_node.building_intersection_dict[start_pos].append(new_intersecting_wheel)

					for intersection in Building_node.building_intersection_dict.keys():
						var intersection_elements = Building_node.building_intersection_dict[intersection]

# Function to get the plank list
func get_wheel_list():
	return wheel_list

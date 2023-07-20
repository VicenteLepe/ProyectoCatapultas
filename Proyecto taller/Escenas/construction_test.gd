extends Node2D

func _ready():
	load_data()
func _input(event):
	if event.is_action_pressed("load"):
		load_data()

func load_data():
	var file = FileAccess.open("user://data.json", FileAccess.READ)
	var data = file.get_var() 
	print("Creo que esto es: ",data)
#var building_base_scene = preload("res://Escenas/BuildingScenes/building_base.tscn")
#var building_plank_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")
#var building_wheel_scene = preload("res://Escenas/BuildingScenes/building_wheel.tscn")
#var building_bucket_scene = preload("res://Escenas/BuildingScenes/building_bucket.tscn")
#
#var test_dictionary = preload("res://Escenas/test_dictionary.tscn")
#
#@export var elements : Dictionary
##@export var intersections : Dictionary
#@export var intersections : Dictionary
#
#func base_shape(end_pos, start_pos, building_base, collision_shape, sprite):
#	# define the position of the plank
#	building_base.position = (start_pos + end_pos) / 2
#	building_base.rotation = (end_pos - start_pos).angle()
#	# calculate the scale factor
#	var length = (end_pos - start_pos).length()
#	# scale the length of the plank
#	collision_shape.shape.extents.x = length/2
#	sprite.scale.x = length/85
#	building_base.get_child(0).player = Game.player
#
#func plank_shape(end_pos, start_pos, building_plank, collision_shape, sprite):
#	# define the position of the plank
#	building_plank.position = (start_pos + end_pos) / 2
#	building_plank.rotation = (end_pos - start_pos).angle()
#	# calculate the scale factor
#	var length = (end_pos - start_pos).length()
#	var collision_shape_length = collision_shape.shape.extents.x * 2
#	var scale_factor = length / collision_shape_length
#	# scale the length of the plank
#	collision_shape.shape.extents.x = length/2 
#	sprite.scale.x = scale_factor
#
#func wheel_shape(end_pos, start_pos, building_wheel, collision_shape, sprite):		
#		# define the position of the wheel
#		building_wheel.position = start_pos
#		# calculate the scale factor
#		var wheel_radius = (end_pos - start_pos).length()
#		# scale the shape of the wheel
#		collision_shape.shape.radius = wheel_radius/2.5
#		sprite.scale.x = wheel_radius/16
#		sprite.scale.y = wheel_radius/16
#
#func bucket_shape(end_pos, start_pos, building_bucket, collision_shape, sprite):		
#	# define the position of the plank
#
#	var bucket = building_bucket.get_node_or_null("Bucket")
#	bucket.position = Vector2((end_pos - start_pos).length()/2,0)
#
#	var pinjoin = building_bucket.get_node_or_null("PinJoint2D")
#	pinjoin.position = Vector2((end_pos - start_pos).length()/2,0)
#
#	var pinjoin2 = building_bucket.get_node_or_null("PinJoint2D2")
#	pinjoin2.position = Vector2(((end_pos - start_pos).length()/2)-10,0)
#
#	building_bucket.position = (start_pos + end_pos) / 2
#	building_bucket.rotation = (end_pos - start_pos).angle()
#	# calculate the scale factor
#	var length = (end_pos - start_pos).length()
#	var collision_shape_length = collision_shape.shape.extents.x * 2
#	var scale_factor = length / collision_shape_length
#	# scale the length of the plank
#	collision_shape.shape.extents.x = length/2 
#	sprite.scale.x = scale_factor
#
#
#func populate_intersection_dict(elements):
#	#importante actualizar el element_node, porque al cambiar de escena seran nulos
#	# cambiar por Game.building_element_dict 
#	#building_intesection_dict = {} y al final return building_intesection_dict
#	# Populate the building_intersection_dict, excluding positions with a count of 1
#	for element_type in elements:
#		for element in elements[element_type]:
#			var element_id = element["element_id"]
#			var positions = element["element_positions"]
#			var element_node = element["element_node"] 
##			if element_type == "Wheel ":
##					positions = element["element_positions"][0]
#
#			for position in positions:
#				if position not in intersections:
#					intersections[position] = []
#				var exists = false
#				for item in intersections[position]:
#					if item["element_type"] == element_type and item["element_id"] == element_id:
#						exists = true
#						break
#
#				if not exists:
#					intersections[position].append({
#						"element_type": element_type,
#						"element_id": element_id,
#						"element_node": element_node
#					})
#	for position in intersections.keys():
#		if len(intersections[position])==1:
#			intersections.erase(position)
#
#func create_pinjoints(intersections):
#	for position in intersections:
#		var element_count = len(intersections[position])
#		for i in range(element_count - 1):
#			for j in range(i + 1, element_count):
#				var first_element = intersections[position][i]["element_node"]
#				var second_element = intersections[position][j]["element_node"]
#				var pin_joint = PinJoint2D.new()
#				pin_joint.node_a = first_element
#				pin_joint.node_b = second_element
#				pin_joint.softness = 0
#				pin_joint.position = position
#				pin_joint.disable_collision = true
#				add_child(pin_joint)	
#
#func check_wheels(elements):
#	if "Wheel" in elements and elements.Wheel.size():
#		if "Base" in elements:
#			for base_dict in elements.Base:
#				base_dict.element_node.has_wheels = true
#
#
#func _ready():
#	var base_dictionary = elements["Base"]
#	for base in base_dictionary:
#		var end_pos = base["element_positions"][1]
#		var start_pos = base["element_positions"][0]
#		var building_base = building_base_scene.instantiate()
#		base["element_node"] = building_base.get_child(0)
#		var rigidbody = building_base.get_node_or_null("RigidBody2D")
#		var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
#		var sprite = rigidbody.get_child(1) # assuming sprite is the second child
#		base_shape(end_pos, start_pos, building_base, collision_shape, sprite)
#		add_child(building_base)
#
#	var plank_dictionary = elements["Plank"]
#	for plank in plank_dictionary:
#		var end_pos = plank["element_positions"][1]
#		var start_pos = plank["element_positions"][0]
#		var building_plank = building_plank_scene.instantiate()
#		plank["element_node"] = building_plank.get_child(0)
#		var rigidbody = building_plank.get_node_or_null("RigidBody2D")
#		var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
#		var sprite = rigidbody.get_child(1) # assuming sprite is the second child
#		plank_shape(end_pos, start_pos, building_plank, collision_shape, sprite)
#		add_child(building_plank)
#
#	var wheel_dictionary = elements["Wheel"]
#	for wheel in wheel_dictionary:
#		var end_pos = wheel["element_positions"][1]
#		var start_pos = wheel["element_positions"][0]
#		var building_wheel = building_wheel_scene.instantiate()
#		wheel["element_node"] = building_wheel.get_child(0)
#		var rigidbody = building_wheel.get_node_or_null("RigidBody2D")
#		var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
#		var sprite = rigidbody.get_child(1) # assuming sprite is the second child
#		wheel_shape(end_pos, start_pos, building_wheel, collision_shape, sprite)
#		add_child(building_wheel)
#
#	var bucket_dictionary = elements["Bucket"]
#	for bucket in bucket_dictionary:
#		var end_pos = bucket["element_positions"][1]
#		var start_pos = bucket["element_positions"][0]
#		var building_bucket = building_bucket_scene.instantiate()
#		bucket["element_node"] = building_bucket.get_child(0)
#		var rigidbody = building_bucket.get_node_or_null("RigidBody2D")
#		var collision_shape = rigidbody.get_node_or_null("CollisionShape2D")
#		var sprite = rigidbody.get_child(1) # assuming sprite is the second child
#		bucket_shape(end_pos, start_pos, building_bucket, collision_shape, sprite)
#		add_child(building_bucket)
#
#	populate_intersection_dict(elements)
#	create_pinjoints(intersections)
#	#check_wheels(elements)


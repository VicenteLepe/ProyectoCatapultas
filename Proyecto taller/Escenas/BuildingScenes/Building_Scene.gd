extends Node2D

var building_plank_scene = preload("res://Escenas/BuildingScenes/building_plank.tscn")
var start_pos = null
var grid_size = 32

var plank_list = []
var intersection_dict = {}
var plank_id = 0
var intersection_id = 0

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var click_pos = get_local_mouse_position()
			for plank in plank_list:
				var plank_start = plank[1][0]
				var plank_end = plank[1][1]
				var snapped_pos = snapped(click_pos, Vector2(grid_size, grid_size))
				if snapped_pos.distance_to(plank_start) < 5 or snapped_pos.distance_to(plank_end) < 5:
					if snapped_pos not in intersection_dict:
						intersection_dict[snapped_pos]=[]	
					break
			if start_pos == null:
				# first click, record start position
				start_pos = get_local_mouse_position()
				start_pos = snapped(start_pos, Vector2(grid_size, grid_size))
			else:
				# second click, create construction plank
				var end_pos = get_local_mouse_position()
				end_pos = snapped(end_pos, Vector2(grid_size, grid_size))
				if end_pos == start_pos:
					# don't create plank if start and end positions are the same
					return
				var building_plank = building_plank_scene.instantiate()
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
				plank_list.append([plank_id, [start_pos, end_pos], building_plank.get_child(0)])
				plank_id += 1
				
				var intersection_positions = intersection_dict.keys()
				for intersection in intersection_positions:
					var plank_ids = intersection_dict[intersection]
					
					for plank in plank_list:
						var id = plank[0]
						var start = plank[1][0]
						var end = plank[1][1]
						if intersection in [start, end]:
							if id not in plank_ids:
								plank_ids.append(id)
							else:
								# Plank ID already in list, do nothing
								pass
					# Update intersection list with new plank IDs (if any)
					intersection_dict[intersection] = plank_ids
					
				start_pos = null
				for plank in plank_list:
					print("Plank ",plank[0]," at: ",plank[1])
				for intersection in intersection_positions:
					print("Intersection at: ", intersection, " between ", intersection_dict[intersection])
				print("-CONSTRUCTION INSTANCE-")

				for intersection in intersection_positions:
					var intersecting_planks = intersection_dict[intersection]
					var plank_count = intersecting_planks.size()

					# Iterate over all pairs of intersecting planks
					for i in range(plank_count - 1):
						for j in range(i + 1, plank_count):
							var first_plank = plank_list[intersecting_planks[i]][2]
							var second_plank = plank_list[intersecting_planks[j]][2]

							var pin_joint = PinJoint2D.new()
							pin_joint.node_a = first_plank.get_path()
							pin_joint.node_b = second_plank.get_path()
							pin_joint.softness = 0
							pin_joint.position = intersection
							pin_joint.disable_collision = true
							add_child(pin_joint)

	if event is InputEventKey and event.keycode == KEY_P and event.pressed:
		for plank in plank_list:
			var plank_node = plank[2]
			if plank_node.freeze == false:
				plank_node.freeze = true
			else:
				plank_node.freeze = false


func _on_continuar_pressed():
	get_tree().change_scene_to_file("res://Escenas/MainScene/Main.tscn")


func _on_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Escenas/MenuScenes/menu_inicial.tscn")
	
	

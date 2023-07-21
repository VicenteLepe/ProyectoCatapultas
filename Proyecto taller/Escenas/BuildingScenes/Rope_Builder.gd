extends Builder

class_name Rope_builder

var godot = preload("res://icon.svg")

func define_rope_shape(_end_pos, _start_pos, _building_element, object1, object2):		
	# define the position of the plank
	_building_element.position = (_start_pos + _end_pos) / 2
	_building_element.rotation = (_end_pos - _start_pos).angle()
	var join = _building_element.get_node_or_null("SpringRope")
	join.length = (_end_pos - _start_pos).length()
	join.position = Vector2((_end_pos - _start_pos).length()/2,0)
	join.node_a = object1.get_path()
	join.node_b = object2.get_path()
	
	var line = _building_element.get_node_or_null("LineRope")
	var node_a = Node2D.new()
	object2.add_child(node_a)
	node_a.global_position = _start_pos + global_position
	var node_b = Node2D.new()
	object1.add_child(node_b)
	node_b.global_position = _end_pos + global_position
	line.setup(node_a, node_b)
	
	var sprite_a = Sprite2D.new()
	sprite_a.texture = godot
	node_a.add_child(sprite_a)
	
	var sprite_b = Sprite2D.new()
	sprite_b.texture = godot
	sprite_b.modulate = Color.DARK_GOLDENROD
	node_b.add_child(sprite_b)

	# calculate the scale factor
	var length = (_end_pos - _start_pos).length()
	#var collision_shape_length = _collision_shape.shape.extents.x * 2
	#var scale_factor = length / collision_shape_length
	# scale the length of the plank
	#_collision_shape.shape.extents.x = length/2 
	#_sprite.scale.x = scale_factor
	
	_building_element.get_child(0).player = Game.player

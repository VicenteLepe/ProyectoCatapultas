extends Line2D

var node_a : Node2D
var node_b : Node2D

func setup(new_node_a: Node2D, new_node_b: Node2D):
	node_a = new_node_a
	node_b = new_node_b
	clear_points()
	add_point(Vector2())
	add_point(Vector2())
	
func _process(delta):
	if node_a and node_b:
		points[0] = node_a.global_position - global_position
		points[1] = node_b.global_position - global_position

func _ready():
	top_level = true
	

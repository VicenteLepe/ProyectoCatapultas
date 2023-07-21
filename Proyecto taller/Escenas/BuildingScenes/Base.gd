extends RigidBody2D

class_name player_base

var has_wheels = false
var player = ""
signal delete_requested
func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("delete"):
		delete_requested.emit()
	
func _physics_process(_delta):
	if player == "":
		return
	if not has_wheels:
		return
	var move_right = "move_right_"+player
	var move_left = "move_left_"+player
	if Input.is_action_pressed(move_right):
		set_linear_velocity(Vector2(150, get_linear_velocity().y))
	elif Input.is_action_pressed(move_left):
		set_linear_velocity(Vector2(-150, get_linear_velocity().y))
	else:
		set_linear_velocity(Vector2((get_linear_velocity().x - get_linear_velocity().x * 0.5), get_linear_velocity().y))

func take_damage():
	print("Auch base")
	print(player)

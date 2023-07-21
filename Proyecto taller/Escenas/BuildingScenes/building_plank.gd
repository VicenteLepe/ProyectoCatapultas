extends RigidBody2D

class_name player_plank

var player = ""

signal rope_requested
signal delete_requested

func _ready():
	input_event.connect(_on_input_event)
	player=Game.player
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("delete"):
		delete_requested.emit()
		
	if event.is_action_pressed("click"):
		rope_requested.emit()
		
func take_damage():
	print("Auch plank")
	print(player)

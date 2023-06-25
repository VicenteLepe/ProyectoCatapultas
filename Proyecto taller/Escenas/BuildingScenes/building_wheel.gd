extends RigidBody2D

signal delete_requested
func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("delete"):
		delete_requested.emit()
	

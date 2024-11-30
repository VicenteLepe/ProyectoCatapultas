extends RigidBody2D

class_name player_wheel

var player = ""

signal delete_requested
func _ready():
	input_event.connect(_on_input_event)
	player=Game.player

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("delete"):
		delete_requested.emit()

func take_damage(hit):
	if hit<300:
		pass
	elif player == "A":
		Game.player_1_health -= 5
	elif player == "B":
		Game.player_2_health -= 5
	elif hit>1000:
		if player == "A":
			Game.player_1_health -= 10
		if player == "B":
			Game.player_2_health -= 10

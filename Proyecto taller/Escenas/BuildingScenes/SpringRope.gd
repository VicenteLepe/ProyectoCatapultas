extends DampedSpringJoint2D

class_name SpringRope

signal launched

var player = ""

@export var compression_speed = 300
@export var max_compression_percentage = 0.75
@export var launch_force = 3
@export var compress_time = 1
@export var back_to_rest_time = 1
@export var release_time = 0.2


var _back_to_rest = false

var _tween: Tween
var _released = false

func _ready() -> void:
	rest_length = length

func _physics_process(delta: float) -> void:
	if player == "":
		return
	var shoot = "shoot_"+player
	if Input.is_action_just_pressed(shoot):
		if _tween:
			_tween.kill()
		_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		_tween.tween_property(self, "rest_length", length * (1 - max_compression_percentage), compress_time)
	if Input.is_action_just_released(shoot):
		rest_length = launch_force * length
		if _tween:
			_tween.kill()
		_tween = create_tween()
		_tween.tween_property(self, "rest_length", length, back_to_rest_time)
		_release()
		


func _release():
	await get_tree().create_timer(release_time).timeout
	launched.emit()
	

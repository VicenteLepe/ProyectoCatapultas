extends RigidBody2D

class_name LaunchBucket2

@export var projectile_scene: PackedScene 
@onready var marker = $"../Bucket/RigidBody2D2/Marker2D"
@onready var bucket = $"../Bucket/RigidBody2D2"
var projectile: Projectile
signal rope_requested
signal delete_requested

func _ready():
	input_event.connect(_on_input_event)
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("delete"):
		delete_requested.emit()
		
	if event.is_action_pressed("click"):
		rope_requested.emit()

func fire():
	if not is_instance_valid(projectile):
		projectile = projectile_scene.instantiate() as Projectile
		get_tree().root.add_child(projectile)
		projectile.position = bucket.global_position
		projectile.apply_central_impulse(-1000*bucket.global_position.direction_to(marker.global_position))
		await get_tree().create_timer(2).timeout
		projectile.queue_free()
		projectile = null
		


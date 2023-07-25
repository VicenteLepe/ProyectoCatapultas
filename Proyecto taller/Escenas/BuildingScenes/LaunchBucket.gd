extends RigidBody2D

class_name LaunchBucket

@export var projectile_scene: PackedScene 
@onready var marker = $"../Bucket/RigidBody2D2/Marker2D"
@onready var bucket = $"../Bucket/RigidBody2D2"
var projectile: Projectile
signal rope_requested
signal delete_requested


enum PlayerType {
	A, 
	B
}

@export var player: PlayerType


func _ready():
	input_event.connect(_on_input_event)
	match player:
		PlayerType.A:
#			Game.player_A = base
			Game.player = "A"
		PlayerType.B:
#			Game.player_B = base
			Game.player = "B"
	
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
		projectile.apply_central_impulse(bucket.angular_velocity*350*bucket.global_position.direction_to(marker.global_position))
		await get_tree().create_timer(3.5).timeout
		projectile.queue_free()
		projectile = null
		
func take_damage(hit):
	if hit<300:
		pass
	elif player ==0:
		Game.player_1_health -= 10
	elif player == 1:
		Game.player_2_health -= 10
	elif hit>1000:
		if player ==0:
			Game.player_1_health -= 20
		if player == 1:
			Game.player_2_health -= 20
		

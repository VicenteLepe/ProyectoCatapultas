extends RigidBody2D

class_name Projectile

func _ready():
	collision_mask = 0
	collision_layer = 0
	await get_tree().create_timer(0.2).timeout

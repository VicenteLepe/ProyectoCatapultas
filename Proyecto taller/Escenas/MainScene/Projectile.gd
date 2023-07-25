extends RigidBody2D

class_name Projectile

func _ready():
	collision_mask = 0
	collision_layer = 0
	await get_tree().create_timer(0.2).timeout
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(4, true)
	set_collision_mask_value(5, true)
	set_collision_mask_value(6, true)
	collision_layer = 6


func _on_area_2d_body_entered(body):
	print(body)
	print(self.linear_velocity.length())
	if body is player_base:
		if body.has_method("take_damage"):
			body.take_damage(self.linear_velocity.length())
	if body is player_plank:
		if body.has_method("take_damage"):
			body.take_damage(self.linear_velocity.length())
	if body is LaunchBucket:
		if body.has_method("take_damage"):
			body.take_damage(self.linear_velocity.length())
	if body is player_wheel:
		if body.has_method("take_damage"):
			body.take_damage(self.linear_velocity.length())
			

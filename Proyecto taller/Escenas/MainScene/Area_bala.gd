extends Area2D


func _ready():
	collision_mask = 0
	collision_layer = 0
	await get_tree().create_timer(0.2).timeout
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(4, true)
	set_collision_mask_value(5, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

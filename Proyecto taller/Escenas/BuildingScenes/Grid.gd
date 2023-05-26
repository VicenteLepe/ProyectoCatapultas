extends Node2D

var grid_size = 32

func _draw():
	var w = get_viewport_rect().size.x
	var h = get_viewport_rect().size.y
	var x = 0
	var y = 0
	while x < w:
		draw_line(Vector2(x, 0), Vector2(x, h), Color(0.5, 0.5, 0.5))
		x += grid_size
	while y < h:
		draw_line(Vector2(0, y), Vector2(w, y), Color(0.5, 0.5, 0.5))
		y += grid_size

func _input(event):
	if event is InputEventKey and event.keycode == KEY_H and event.pressed:
		if self.is_visible():
			self.hide()
		else:
			self.show()
		

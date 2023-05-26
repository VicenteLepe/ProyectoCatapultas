extends Control

signal building_plank_state

# Inside UI's script
func _ready():
	$Select_element_button.connect("item_selected", self._on_Select_element_button_item_selected)

# Inside UI's script
func _on_Select_element_button_item_selected(index):
	var item_text = $Select_element_button.get_item_text(index)
	if item_text == "Plank":
		emit_signal('building_plank_state', true)
	else:
		emit_signal('building_plank_state', false)

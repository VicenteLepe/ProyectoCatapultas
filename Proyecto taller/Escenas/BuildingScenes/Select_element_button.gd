extends OptionButton
@onready var Select_element_button = get_node("Camera2D/UI/Select_element_button")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Select_element_button is Building:
		if get_selected_id() == 1:
			Select_element_button.activate_building()
		else:
			Select_element_button.deactivate_building()
	else:
		print("Select_element_button is not a Building")

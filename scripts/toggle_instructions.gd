extends Button

@onready var panel_container: PanelContainer = $"../PanelContainer"
@onready var panel_container_3: PanelContainer = $"../PanelContainer3"

var instructions_on = true

func _on_button_up() -> void:
	if (instructions_on):
		panel_container.visible = false
		panel_container_3.visible = false
		instructions_on = false
	else:
		panel_container.visible = true
		panel_container_3.visible = true
		instructions_on = true

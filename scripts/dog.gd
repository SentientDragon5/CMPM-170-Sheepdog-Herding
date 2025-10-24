extends CharacterBody2D

@onready var agent : NavigationAgent2D = $NavigationAgent2D

@export var move_speed : float = 2000
var goal : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	if not agent.is_navigation_finished():
		velocity = global_position.direction_to(agent.get_next_path_position()) * move_speed

func _mouse_enter() -> void:
	#print(name, " mouse enter")
	pass
	
func _mouse_exit() -> void:
	#print(name, " mouse exit")
	pass

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print(name, " has been clicked")
				pass
				
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("mouse clicked at ", get_global_mouse_position())

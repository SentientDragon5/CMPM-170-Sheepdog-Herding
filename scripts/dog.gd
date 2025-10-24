extends CharacterBody2D

@onready var agent : NavigationAgent2D = $NavigationAgent2D

@onready var selected_ui: Sprite2D = $Selected
@onready var goal_arrow: Sprite2D = $GoalArrow

@export var my_color : Color = Color.RED

@export var _selected : bool = false
var selected:
	get:
		return _selected
	set(value):
		_selected = value
		selected_ui.visible = _selected

@export var move_speed : float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if not agent.is_navigation_finished():
		goal_arrow.global_position = agent.target_position
		goal_arrow.visible = true
		velocity = global_position.direction_to(agent.get_next_path_position()) * move_speed
	else:
		goal_arrow.visible = false
		velocity = Vector2.ZERO
	move_and_slide()

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
				selected = true
				
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("mouse clicked at ", get_global_mouse_position())
				if selected:
					agent.target_position = get_global_mouse_position()
			if event.button_index == MOUSE_BUTTON_RIGHT:
				selected = false

extends CharacterBody2D

@onready var agent : NavigationAgent2D = $NavigationAgent2D

@onready var wolf_sprite: Sprite2D = $WolfSprite
@onready var selected_ui: Sprite2D = $Selected
@onready var goal_arrow: Sprite2D = $GoalArrow

@export var move_speed : float = 500.0

@export var _selected : bool = false

@onready var audio_player = $AudioStreamPlayer2D

		
func _ready() -> void:
	_selected = false
	add_to_group("Dog")

func _physics_process(_delta: float) -> void:
	click_navigation()
	navigate()

func click_navigation() -> void:
	if Input.is_action_just_pressed("left_click") and _selected:
			_selected = false
			selected_ui.visible = false
			agent.target_position  = get_global_mouse_position()
			goal_arrow.visible = true

func navigate() -> void:
	if agent.is_navigation_finished():
		goal_arrow.visible = false
		return
	var next_path_position: Vector2 = agent.get_next_path_position()
	var new_velocity:Vector2 = (
		global_position.direction_to(next_path_position) * move_speed
	)
	agent.velocity = new_velocity
	rotation = new_velocity.angle() + deg_to_rad(90)
	goal_arrow.global_position = agent.target_position
	goal_arrow.global_rotation = 0

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	position += safe_velocity * get_physics_process_delta_time()
	


func _on_area_2d_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_released("left_click"):
		if not _selected:
			_selected = true
			selected_ui.visible = true
			
			# Play dog sound with random pitch on selection
			#audio_player.pitch_scale = randf_range(0.8, 1.2)
			audio_player.play()
		else:
			_selected = false
			selected_ui.visible = false

class_name  Dog
extends CharacterBody2D

@onready var agent : NavigationAgent2D = $NavigationAgent2D


@onready var clickableArea: Area2D = $Area2D
@onready var repulsion: Area2D = $Repulsion

@onready var wolf_sprite: Sprite2D = $WolfSprite
@onready var selected_ui: Sprite2D = $Selected
@onready var goal_arrow: Sprite2D = $GoalArrow

@export var my_color : Color = Color.RED
@export var move_speed : float = 500.0

@export var _selected : bool = false

		
func _ready() -> void:
	_selected = false

func _physics_process(delta: float) -> void:
	#click_navigation()
	navigate()
	repulse_sheep()

func repulse_sheep() -> void:
	for body in repulsion.get_overlapping_bodies():
		if body is Sheep:
			body.run_from_dog(self)

#func click_navigation() -> void:
	#if Input.is_action_just_pressed("left_click") and _selected:
		#if not wolf_sprite.is_pixel_opaque(get_local_mouse_position()):
			#_selected = false
			#selected_ui.visible = false
			#agent.target_position  = get_global_mouse_position()
			#goal_arrow.visible = true


func navigate() -> void:
	if agent.is_navigation_finished():
		goal_arrow.visible = false
		return
	var next_path_position: Vector2 = agent.get_next_path_position()
	var new_velocity:Vector2 = (
		global_position.direction_to(next_path_position) * move_speed
	)
	goal_arrow.global_position = agent.target_position
	agent.velocity = new_velocity
	wolf_sprite.rotation = new_velocity.angle() + deg_to_rad(90)

func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		if not _selected:
			_selected = true
			selected_ui.visible = true
		else:
			_selected = false
			selected_ui.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if _selected:
					selected_ui.visible = false
					agent.target_position  = get_global_mouse_position()
					goal_arrow.visible = true
					print("mouse clicked at ", get_global_mouse_position())
					_selected = false

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	position += safe_velocity * get_physics_process_delta_time() 

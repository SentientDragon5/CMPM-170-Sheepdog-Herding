class_name Sheep
extends CharacterBody2D

@export var _speed = 50
var _direction = Vector2()
@onready var run_timer: Timer = $RunTimer
var last_dog : Dog
@onready var wander_timer: Timer = $WanderTimer

func _ready() -> void:
	wander()

func _physics_process(delta: float) -> void:
	if run_timer.time_left > 0:
		_direction = (global_position - last_dog.global_position).normalized()
	$Label.text = str(run_timer.time_left)
	
	velocity = _direction * _speed
	rotation = atan2(_direction.y, _direction.x) + deg_to_rad(90)
	move_and_slide()

func run_from_dog(dog : Dog) -> void:
	last_dog = dog
	run_timer.start()
	wander_timer.stop()
	

func _on_run_timer_timeout() -> void:
	wander()

func wander():
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_timer.start(randf_range(1, 2.5))

func _on_wander_timer_timeout() -> void:
	wander()

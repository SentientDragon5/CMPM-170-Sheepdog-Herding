extends CharacterBody2D

@export var _speed = 20
var _direction = Vector2()

var threatening_dogs = []


func _ready() -> void:
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _physics_process(delta: float) -> void:
	
	velocity = _direction.normalized() * _speed
	rotation = atan2(_direction.y, _direction.x) + deg_to_rad(90)
	move_and_slide()
	
	
	

extends CharacterBody2D

@export var _speed = 20
var _direction = Vector2()

var threatening_dogs = []


func _ready() -> void:
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _physics_process(delta: float) -> void:
	var flee_direction = Vector2.ZERO
	for dog in threatening_dogs:
		var diff = global_position - dog.global_position
		if diff.length() > 0.1:
			flee_direction += diff.normalized()
	if flee_direction != Vector2.ZERO:
		flee_direction = flee_direction.normalized()
		velocity = flee_direction * _speed
		rotation = atan2(flee_direction.y, flee_direction.x) + deg_to_rad(90)
		move_and_slide()
	else:
		# idle or other behavior if not threatened
		velocity = _direction * _speed
		rotation = atan2(_direction.y, _direction.x) + deg_to_rad(90)
		move_and_slide()

func start_fleeing_from(dog):
	if dog not in threatening_dogs:
		threatening_dogs.append(dog)

func stop_fleeing_from(dog):
	threatening_dogs.erase(dog)
	
	

extends RigidBody2D

@export var _speed = 20
@export var _alignment_multiplier = 40
@export var _cohesion_multiplier = 40
@export var _separation_multiplier = 40
var _direction = Vector2()

var threatening_dogs = []
var neighboring_sheep = []

func _ready() -> void:
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	add_to_group("Sheep")
	


func _physics_process(_delta: float) -> void:
	_direction += _alignment()
	_direction += _cohesion()
	#_direction += _separation()
	linear_velocity = _direction.normalized() * _speed
	rotation = atan2(_direction.y, _direction.x) + deg_to_rad(90)
	
func _on_detection_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Sheep")):
		neighboring_sheep.append(body)
	else:
		_direction = -_direction

		
func _on_detection_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Sheep")):
		neighboring_sheep.erase(body)

func _alignment() -> Vector2: 
	if neighboring_sheep.size() == 0:
		return _direction

	var average_velocity = Vector2.ZERO
	for sheep in neighboring_sheep:
		average_velocity += sheep.linear_velocity 
	average_velocity /= neighboring_sheep.size()
		
	return average_velocity 
	
func _cohesion() -> Vector2: 
	if neighboring_sheep.size() == 0:
		return _direction

	var average_location = Vector2.ZERO
	for sheep in neighboring_sheep:
		average_location += sheep.position 
	average_location /= neighboring_sheep.size()
		
	return position.direction_to(average_location) 

func _separation() -> Vector2: 
	if neighboring_sheep.size() == 0:
		return _direction

	var separation = Vector2.ZERO
	for sheep in neighboring_sheep:
		separation += (position - sheep.position / position.distance_to(sheep.position))
	separation /= neighboring_sheep.size()
	return separation

# backup reflection
func _on_body_entered(body: Node) -> void:
	if (body.name == "Rocks"):
		_direction = -position.direction_to(body.position)

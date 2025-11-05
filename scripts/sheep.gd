extends RigidBody2D

@export var _speed = 20
@export var _alignment_multiplier = 2
@export var _cohesion_multiplier = 2
@export var _separation_multiplier = 2
var _direction = Vector2()

var threatening_dogs = []
var neighboring_sheep = []

func _ready() -> void:
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	add_to_group("Sheep")
	


func _physics_process(_delta: float) -> void:
	_direction += _flock_behavior()
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
		
func _flock_behavior() -> Vector2:
	if neighboring_sheep.size() == 0:
		return _direction
	
	var alignment_vector = Vector2.ZERO
	var cohesion_vector = Vector2.ZERO 
	var separation_vector = Vector2.ZERO
	
	for sheep in neighboring_sheep:
		alignment_vector += sheep.linear_velocity 
		cohesion_vector += sheep.global_position
		separation_vector += ((global_position - sheep.global_position) / clamp(global_position.distance_to(sheep.global_position), 0.01 , INF))
	
	alignment_vector /= neighboring_sheep.size() 
	cohesion_vector = global_position.direction_to(cohesion_vector/neighboring_sheep.size())
	separation_vector /= neighboring_sheep.size()
	
	alignment_vector *= _alignment_multiplier 
	cohesion_vector *= _cohesion_multiplier 
	separation_vector *= _separation_multiplier 
	
	return alignment_vector + cohesion_vector + separation_vector

# backup reflection
func _on_body_entered(body: Node) -> void:
	if (body.name == "Rocks"):
		_direction = -_direction

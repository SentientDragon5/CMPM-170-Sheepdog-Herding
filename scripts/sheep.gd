extends RigidBody2D

@export var _speed = 20
var _direction = Vector2()

var threatening_dogs = []
var neighboring_sheep = []

func _ready() -> void:
	_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	add_to_group("Sheep")
	


func _physics_process(delta: float) -> void:
	_direction = _alignment()
	linear_velocity = _direction.normalized() * _speed
	rotation = atan2(_direction.y, _direction.x) + deg_to_rad(90)
	

func _on_body_entered(body: Node) -> void:
	_direction = (position - body.position).normalized()


func _on_detection_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Sheep")):
		neighboring_sheep.append(body)
		
func _on_detection_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Sheep")):
		neighboring_sheep.erase(body)
	
func _alignment() -> Vector2: 
	if neighboring_sheep.size() == 0:
		return _direction
	var average_direction = Vector2.ZERO
	for sheep in neighboring_sheep:
		average_direction += sheep.linear_velocity 
	average_direction /= neighboring_sheep.size()
	return average_direction
	

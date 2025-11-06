extends Node

@export var sheep_count = 0
@onready var total_sheep = $"../SheepSpawner".initial_count
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Sheep")):
		sheep_count += 1
		
func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Sheep")):
		sheep_count -= 1

extends Node

var animals;
var track_speed = 0.5;

func _ready() -> void:
	animals = get_tree().get_nodes_in_group("animal")

func _process(_delta: float) -> void:
	# get avg position from everythnig tagged "cam follow"
	var sum = Vector2(0,0)
	var total=0;
	for animal in animals:
		sum += animal.position
		total += 1
	var avgPos = sum/total
	
	self.position.x = move_toward(self.position.x, avgPos.x, track_speed)
	self.position.y = move_toward(self.position.y, avgPos.x, track_speed)
	
	
	# use get_tree().get_nodes_in_group("cam follow")
	# move camera to that position
	# 
	pass

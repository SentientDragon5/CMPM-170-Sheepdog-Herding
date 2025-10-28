extends Node

var animals;
var track_speed = 2;

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
	
	self.position.x = lerp(self.position.x, avgPos.x, track_speed * _delta)
	self.position.y = lerp(self.position.y, avgPos.y, track_speed * _delta)
	
	
	# use get_tree().get_nodes_in_group("cam follow")
	# move camera to that position
	# 
	pass

extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _mouse_enter() -> void:
	print(name, " mouse enter")
	pass
	
func _mouse_exit() -> void:
	print(name, " mouse exit")
	pass

func _input_event(_viewport: Viewport, _event: InputEvent, _shape_idx: int) -> void:
	print(name, " has been clicked")

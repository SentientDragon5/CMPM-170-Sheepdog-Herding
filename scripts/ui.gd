extends Control

@onready var sheep_counter: Area2D = $"../SheepCounter"

@onready var goal: Label = %Goal
@onready var sheep_counter_text: Label = %SheepCounterText


func _process(_delta: float) -> void:
	sheep_counter_text.text = "Sheep: %s/%s" % [str(sheep_counter.sheep_count), str(sheep_counter.total_sheep)]

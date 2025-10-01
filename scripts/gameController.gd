extends Node2D

@onready var box = preload("res://scenes/Boxes.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"

func _on_timer_timeout() -> void:
	var boxInstance = box.instantiate()
	boxInstance.position = boxSpawner.position
	add_child(boxInstance)
	print("box spawned in")
	$Timer.start()
	

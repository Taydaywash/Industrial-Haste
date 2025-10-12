extends Node2D

@onready var box_controller = $"../Boxes"
@onready var box = preload("res://scenes/boxes.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"

var count = 0

func _on_timer_timeout() -> void:
	var boxInstance = box.instantiate()
	boxInstance.position = boxSpawner.position
	boxInstance.match_box(boxInstance.get_box_type())
	add_child(boxInstance)
	print("box spawned in")
	count += 1
	$Timer.start()
	
func print2():
	print("Hello")

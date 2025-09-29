extends Node2D

@export var boxSpeed = 300

@onready var box_spawner: Node2D = $"../BoxSpawner"

func _process(delta: float):
	position.x += boxSpeed * delta 

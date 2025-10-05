extends Node2D

@export var boxSpeed = 200
@export_enum ("Normal", "Opened", "Tapeless", "Dirty", "Mislabeled", "Bulging") var boxType: int

@onready var box_spawner: Node2D = $"../BoxSpawner"

func _ready() -> void:
	pass

func _process(delta: float):
	position.x += boxSpeed * delta 

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("box deleted")
	queue_free()

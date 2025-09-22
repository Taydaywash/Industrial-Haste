extends Sprite2D
@export var boxSpeed = 300
@onready var box_spawner: Node2D = $"../BoxSpawner"



func _process(delta: float):
	position.x += boxSpeed * delta 
	if position.x > 700:
		position.x = box_spawner.position.x

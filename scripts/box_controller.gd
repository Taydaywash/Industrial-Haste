extends Node2D

@export var boxSpeed = 150
@export_enum ("Normal", "Opened", "Tapeless", "Dirty", "Mislabeled", "Bulging") var boxType: int
@export var boxList = ["Normal", "Opened", "Tapeless", "Dirty", "Mislabeled", "Bulging"]
@export var conditon = "fixed"

@onready var box_spawner: Node2D = $"../BoxSpawner"

func _ready() -> void:
	match boxType:
		0:
			$Area2D/Sprite.modulate = Color("red")
		1:
			$Area2D/Sprite.modulate = Color("orange")
		2:
			$Area2D/Sprite.modulate = Color("yellow")
		3:
			$Area2D/Sprite.modulate = Color("green")
		4:
			$Area2D/Sprite.modulate = Color("blue")
		5:
			$Area2D/Sprite.modulate = Color("purple")
		_:
			pass
	

func _process(delta: float):
	position.x += boxSpeed * delta 

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("box deleted")
	queue_free()
	
#func _change_box(number: int):
	#boxType = boxList[number]
	

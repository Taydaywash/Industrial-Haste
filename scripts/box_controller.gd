extends Node2D

@export var boxSpeed = 150
@export var boxType: Dictionary = {"Fixed": 50, "Opened": 65, "Tapeless": 70,
								   "Dirty": 85, "Mislabeled": 90 , "Bulging": 100}

@onready var box_spawner: Node2D = $"../BoxSpawner"

var rng = RandomNumberGenerator.new()

func _process(delta: float):
	position.x += boxSpeed * delta 

func _on_visible_on_screen_notifier_2d_screen_exited():
	#print("box deleted")
	queue_free()

func get_box_type():
	rng.randomize()
	
	var item = rng.randi_range(0,100)
	
	for n in boxType:
		if item <= boxType[n]:
			#print(item)
			return n
	
	
func match_box(type: String) -> void:
	match type:
		"Fixed":
			$Area2D/Sprite.modulate = Color("red")
		"Opened":
			$Area2D/Sprite.modulate = Color("orange")
		"Tapeless":
			$Area2D/Sprite.modulate = Color("yellow")
		"Dirty":
			$Area2D/Sprite.modulate = Color("green")
		"Mislabeled":
			$Area2D/Sprite.modulate = Color("blue")
		"Bulging":
			$Area2D/Sprite.modulate = Color("purple")
		_:
			pass

extends Node2D

@export var boxSpeed = 150
@export var boxTypes: Dictionary = {"Fixed": 50, "Opened": 65, "Tapeless": 100,
								   "Dirty": 85, "Mislabeled": 90 , "Bulging": 100}
var boxType
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
	
	for n in boxTypes:
		if item <= boxTypes[n]:
			#print(item)
			boxType = n
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

func _attempt_tool_use(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#mouseup
	var tool = Global._get_tool()
	if event is InputEventMouseButton and !event.pressed:
		print("Attempted to use tool #" + str(tool) + " on " + boxType)
		match tool:
			0: #Hand Tool
				pass
			1: #Tape Tool
				if (boxType == "Tapeless"):
					print("Fixed Tapeless Box!")
				else:
					print("Tool #" + str(tool) + " cannot be used to fix Tapeless Box")
			2: #Wrench Tool
				pass
			3: #Bolts Tool
				pass
			_:
				pass

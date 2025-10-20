extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fixedTexture = preload("res://spirtes/BoxSprites/fixedBox.png")

@export var boxSpeed = 150
@export var boxTypes: Dictionary = {
	"Fixed": 50, 
	"Opened": 65, 
	"Tapeless": 70,
	"Dirty": 85, 
	"Mislabeled": 90, 
	"Bulging": 100, 
	"Loose Bolt": 101, #Unused Currently
	"Boltless": 101 #Unused Currently
	}
var boxType
@onready var box_spawner: Node2D = $"../BoxSpawner"

var rng = RandomNumberGenerator.new()

var rotationRate = 0

func _process(delta: float):
	get_child(0).rotation += rotationRate * delta 
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
		"Loose Bolt":
			$Area2D/Sprite.modulate = Color("black")
		"Boltless":
			$Area2D/Sprite.modulate = Color("white")
		_:
			pass

func _attempt_tool_use(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#mouseup
	
	var tool = Global._get_tool()
	if event is InputEventMouseButton and event.pressed:
		animation_player.play("pushedOffLine")
	if event is InputEventMouseButton and !event.pressed:
		print("Attempted to use tool #" + str(tool) + " on " + boxType)
		match tool:
			1: #Tape Tool
				if (boxType == "Tapeless" || boxType == "Opened"):
					print("Fixed " + boxType)
				else:
					print("Tool #" + str(tool) + " cannot be used on " + boxType)
			2: #Wrench Tool
				if (boxType == "Loose Bolt" || boxType == "Boltless" ):
					print("Tighted bolt on " + boxType)
				else:
					print("Tool #" + str(tool) + " cannot be used on " + boxType)
			3: #Bolts Tool
				if (boxType == "Boltless"):
					print("Added Bolt to Boltless Crate!!")
				else:
					print("Tool #" + str(tool) + " cannot be used on " + boxType)
			_:
				pass

func rotate_box():
	boxSpeed = boxSpeed/10
	rotationRate = -((get_local_mouse_position() - get_child(0).position)).x/20

extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var boxLabel: Label = $Area2D/BoxLabel
@onready var fixedTexture = preload("res://spirtes/BoxSprites/fixedBox.png")
@onready var openedTexture = preload("res://spirtes/BoxSprites/openedBox.png")
@onready var tapelessTexture = preload("res://spirtes/BoxSprites/tapelessBox.png")
@onready var dirtyTexture = preload("res://spirtes/BoxSprites/dirtyBox.png")
@onready var box_spawner: Node2D = $"../BoxSpawner"
@onready var score: Label = $"../Score"

var boxSpeed = 150
var boxTypes: Dictionary = {
	"Fixed": 0, 
	"Opened": 0, 
	"Tapeless": 0,
	"Dirty": 0, 
	"Mislabeled": 0, 
	"Bulging": 0, 
	"Loose Bolt": 0, 
	"Boltless": 0 
	}
var safeBoxes: Array = []
var boxType

var rng = RandomNumberGenerator.new()
var rotationRate = 0

#Box Spawning Behavior
func _ready() -> void:
	boxTypes = Global._get_spawn_rates()
	safeBoxes = Global._get_safe_boxes()
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
			$Area2D/Sprite.texture = fixedTexture
		"Opened":
			$Area2D/Sprite.texture = openedTexture
		"Tapeless":
			$Area2D/Sprite.texture = tapelessTexture
		"Dirty":
			$Area2D/Sprite.texture = dirtyTexture
		"Mislabeled":
			$Area2D/Sprite.texture = fixedTexture
		"Bulging":
			$Area2D/Sprite.modulate = Color("purple")
		"Loose Bolt":
			$Area2D/Sprite.modulate = Color("black")
		"Boltless":
			$Area2D/Sprite.modulate = Color("white")
		_:
			pass
func change_label(count: int) -> void:
	boxLabel.text = str(count)

#Point Scoring Behavior
func _on_visible_on_screen_notifier_2d_screen_exited():
	#print("box deleted")
	if boxType == "Fixed" || boxType in safeBoxes:
		score.add_points(100)
	else:
		score.subtract_points(200)
	queue_free()
func _attempt_tool_use(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var tool = Global._get_tool()
	
	#Mouse Down
	if event is InputEventMouseButton and event.pressed:
		animation_player.play("pushedOffLine")
		SoundManager.play_whoosh_sound()
		if boxType == "Fixed" || boxType in safeBoxes:
			score.subtract_points(200)
		else:
			score.add_points(100)
		Global._reset_tool()
	
	#Mouse Up
	if event is InputEventMouseButton and !event.pressed:
		print("Attempted to use tool #" + str(tool) + " on " + boxType)
		match tool:
			1: #Tape Tool
				if (boxType == "Tapeless" || boxType == "Opened"):
					animation_player.play("Fixed Box")
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
		Global._reset_tool()
func fix_box():
	$Area2D/Sprite.texture = fixedTexture
	boxType = "Fixed"

#Animation Variations
func rotate_box():
	rotationRate = -((get_local_mouse_position() - get_child(0).position)).x/20
	boxSpeed = (boxSpeed * rotationRate)/4
func _process(delta: float):
	get_child(1).rotation += rotationRate * delta 
	position.x += boxSpeed * delta 

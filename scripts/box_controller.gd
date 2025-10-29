extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var boxLabel: Label = $Area2D/BoxLabel
@onready var fixedTexture = preload("res://spirtes/BoxSprites/fixedBox.png")
@onready var openedTexture = preload("res://spirtes/BoxSprites/openedBox.png")
@onready var tapelessTexture = preload("res://spirtes/BoxSprites/tapelessBox.png")
@onready var dirtyTexture = preload("res://spirtes/BoxSprites/dirtyBox.png")
@onready var fixedCrate = preload("res://spirtes/BoxSprites/fixedCrate.png")
@onready var boltlessCrate = preload("res://spirtes/BoxSprites/boltlessCrate.png")

@onready var FixedLeftBolt = preload("res://spirtes/bolts/fixedLeftBolt.png")
@onready var FixedRightBolt = preload("res://spirtes/bolts/fixedRightBolt.png")
@onready var LooseLeftBolt = preload("res://spirtes/bolts/looseLeftBolt.png")
@onready var LooseRightBolt = preload("res://spirtes/bolts/looseRightBolt.png")


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
var unsafeDiscardBoxes: Array = []
var boxType


#Crate Controller
@onready var bolts: Node2D = $Area2D/Bolts

var looseBoltAmt = 0
var missingBoltAmt = 0
# 0 = Fixed Bolt
# 1 = Loose Bolt
# 2 = Missing Bolt
var boltPositions: Array = [0,
							0,
							0,
							0]


var rng = RandomNumberGenerator.new()
var rotationRate = 0

#Box Spawning Behavior
func _ready() -> void:
	boxTypes = Global._get_spawn_rates()
	safeBoxes = Global._get_safe_boxes()
	unsafeDiscardBoxes = Global._get_unsafe_discard_boxes()
func get_box_type():
	rng.randomize()
	
	var item = rng.randi_range(0,99)
	
	for n in boxTypes:
		if item < boxTypes[n]:
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
		"Fixed Crate":
			$Area2D/Sprite.texture = fixedCrate
			boxLabel.visible = false
			_set_bolt_sprites()
		"Loose Bolt":
			$Area2D/Sprite.texture = boltlessCrate
			boxLabel.visible = false
			looseBoltAmt = randi_range(1,2)
			_set_bolt_positions(looseBoltAmt, 1)
			_set_bolt_sprites()
			
		"Boltless":
			$Area2D/Sprite.texture = boltlessCrate
			boxLabel.visible = false
			missingBoltAmt = randi_range(1,3)
			_set_bolt_positions(missingBoltAmt, 2)
			_set_bolt_sprites()

		_:
			pass
func change_label(count: int) -> void:
	boxLabel.text = str(count)

#Crate Behaviors
func _set_bolt_positions(boltAmt, type: int):
	boltPositions = [0,0,0,0]
	for i in range(0,boltAmt):
		var boltPos = randi_range(0,3)
		while boltPositions[boltPos] != 0:
			boltPos = randi_range(0,3)
		boltPositions[boltPos] = type 
func _set_bolt_sprites():
	for index in range(0,4):
		var bolt = bolts.get_child(index)
		bolt.visible = true
		if boltPositions[index] == 0:
			if index < 2:
				bolt.texture = FixedLeftBolt
			else:
				bolt.texture = FixedRightBolt
		elif boltPositions[index] == 1:
			if index < 2:
				bolt.texture = LooseLeftBolt
			else:
				bolt.texture = LooseRightBolt
		else:
			bolt.visible = false
func _fixed_bolt():
	looseBoltAmt -= 1
	for index in range(0,4):
		if boltPositions[index] > 0:
			boltPositions[index] -= 1
			break
	if looseBoltAmt == 0:
		boxType = "Fixed"
	_set_bolt_sprites()
func _added_bolt():
	looseBoltAmt += 1
	missingBoltAmt -= 1
	for index in range(0,4):
		if boltPositions[index] == 2:
			boltPositions[index] = 1
			break
	print(boltPositions)
	_set_bolt_sprites()

#Point Scoring Behavior
func _on_visible_on_screen_notifier_2d_screen_exited():
	if boxType in safeBoxes:
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
		if boxType in safeBoxes || boxType in unsafeDiscardBoxes:
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
					if (looseBoltAmt > 0):
						_fixed_bolt()
						print("Fixed bolt on " + boxType)
					else:
						print("Tried to fix bolt on " + boxType + "... but there were no bolts to fix!")
				else:
					print("Tool #" + str(tool) + " cannot be used on " + boxType)
			3: #Bolts Tool
				if (boxType == "Boltless"):
					if (missingBoltAmt > 0):
						_added_bolt()
						print("Added bolt to Boltless crate")
					else:
						print("Tried to add bolt to " + boxType + "... but there were no bolts to add!")
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

extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var boxLabel: Label = $Area2D/BoxLabel

@onready var box_spawner: Node2D = $"../BoxSpawner"
@onready var score: Label = $"../Score"

var boxSpeed = Global.currentBoxSpeed
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

#Box Textures
var fixedTextures = []
var openedTextures = []
var tapelessTextures = []
var dirtyTextures = []
var bulgingTextures = []
#var fixedCrates = []
var boltlessCrates = []
var LooseLeftBolts = []
var LooseRightBolts = []

var boxLabelNumber = 0
#Box Spawning Behavior
var boxes
func _ready() -> void:
	boxes = get_parent()
	fixedTextures = boxes.fixedTextures
	openedTextures = boxes.openedTextures
	tapelessTextures = boxes.tapelessTextures
	dirtyTextures = boxes.dirtyTextures
	bulgingTextures = boxes.bulgingTextures
	#fixedCrates = boxes.fixedCrates
	boltlessCrates = boxes.boltlessCrates
	LooseLeftBolts = boxes.LooseLeftBolts
	#LooseRightBolts = boxes.LooseRightBolts
	boxTypes = Global._get_spawn_rates()
	safeBoxes = Global._get_safe_boxes()
	unsafeDiscardBoxes = Global._get_unsafe_discard_boxes()
	Global._add_box_to_scene(self)

func _set_speed_to(speed):
	if rotationRate==0:
		boxSpeed = speed

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
			$Area2D/Sprite.texture = fixedTextures[randi_range(0,fixedTextures.size()-1)]
		"Opened":
			$Area2D/Sprite.texture = openedTextures[randi_range(0,openedTextures.size()-1)]
		"Tapeless":
			$Area2D/Sprite.texture = tapelessTextures[randi_range(0,tapelessTextures.size()-1)]
		"Dirty":
			$Area2D/Sprite.texture = dirtyTextures[randi_range(0,dirtyTextures.size()-1)]
		"Mislabeled":
			$Area2D/Sprite.texture = fixedTextures[randi_range(0,fixedTextures.size()-1)]
		"Bulging":
			$Area2D/Sprite.texture = bulgingTextures[randi_range(0,bulgingTextures.size()-1)]
		"Fixed Crate":
			$Area2D/Sprite.texture = boltlessCrates[randi_range(0,boltlessCrates.size()-1)]
			boxLabel.visible = false
			_set_bolt_sprites([3,3,3,3])
		"Loose Bolt":
			$Area2D/Sprite.texture = boltlessCrates[randi_range(0,boltlessCrates.size()-1)]
			boxLabel.visible = false
			looseBoltAmt = randi_range(1,2)
			_set_bolt_positions(looseBoltAmt, 1)
			_set_bolt_sprites([3,3,3,3])
			
		"Boltless":
			$Area2D/Sprite.texture = boltlessCrates[randi_range(0,boltlessCrates.size()-1)]
			boxLabel.visible = false
			missingBoltAmt = randi_range(1,2)
			_set_bolt_positions(missingBoltAmt, 2)
			_set_bolt_sprites([3,3,3,3])

		_:
			pass
func change_label(count: int) -> void:
	if boxType == "Mislabeled":
		var rand = randi_range(-5,5)
		if rand == 0:
			rand = 1
		boxLabel.text = str(count + rand)
	else:
		boxLabel.text = str(count)

#Crate Behaviors
func _set_bolt_positions(boltAmt, type: int):
	boltPositions = [0,0,0,0]
	for i in range(0,boltAmt):
		var boltPos = randi_range(0,3)
		while boltPositions[boltPos] != 0:
			boltPos = randi_range(0,3)
		boltPositions[boltPos] = type 

func _set_bolt_sprites(lastBoltPositions):
	for index in range(0,4):
		var bolt = bolts.get_child(index)
		bolt.visible = true
		if boltPositions[index] == 0:
			bolt.texture = boxes.FixedLeftBolt
			if index < 2:
				bolt.flip_h = false
			else:
				bolt.flip_h = true
		elif boltPositions[index] == 1 && lastBoltPositions[index] != 1:
			bolt.texture = LooseLeftBolts[randi_range(0,LooseLeftBolts.size()-1)]
			if index < 2:
				bolt.flip_h = false
			else:
				bolt.flip_h = true
		else:
			if boltPositions[index] == lastBoltPositions[index]:
				bolt.visible = true
			else:
				bolt.visible = false

func _fixed_bolt():
	var lastBoltPositions = boltPositions
	looseBoltAmt -= 1
	for index in range(0,4):
		if boltPositions[index] > 0:
			boltPositions[index] -= 1
			animation_player.play("Screwed_Bolt_"+str(index))
			SoundManager.play_bolt_screwed_sound()
			break
	if boltPositions == [0,0,0,0]:
		boxType = "Fixed"
		animation_player.play("Fixed Crate")
	_set_bolt_sprites(lastBoltPositions)

func _added_bolt():
	var lastBoltPositions = boltPositions
	looseBoltAmt += 1
	missingBoltAmt -= 1
	for index in range(0,4):
		if boltPositions[index] == 2:
			boltPositions[index] = 1
			break
	print(boltPositions)
	_set_bolt_sprites(lastBoltPositions)
	SoundManager.play_bolt_placed_sound()

#Point Scoring Behavior
func _on_visible_on_screen_notifier_2d_screen_exited():
	if boxType in safeBoxes:
		score._add_points(100)
	else:
		score._subtract_points(200)
	queue_free()

func _attempt_tool_use(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var tool = Global._get_tool()
	
	#Mouse Down
	if event is InputEventMouseButton and event.pressed:
		animation_player.play("pushedOffLine")
		SoundManager.play_whoosh_sound()
		if boxType in safeBoxes || boxType in unsafeDiscardBoxes:
			score._subtract_points(200)
		else:
			score._add_points(100)
		Global._reset_tool()
	
	#Mouse Up
	if event is InputEventMouseButton and !event.pressed:
		print("Attempted to use tool #" + str(tool) + " on " + boxType)
		match tool:
			1: #Tape Tool
				if (boxType == "Tapeless" || boxType == "Opened"):
					animation_player.play("Fixed Box")
					SoundManager.play_tape_placed_sound()
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
	$Area2D/Sprite.texture = fixedTextures[randi_range(0,fixedTextures.size()-1)]
	boxType = "Fixed"
	
#Method to call in the animation player
func poof_sound():
	SoundManager.play_poof_sound()

#Animation Variations
func rotate_box():
	rotationRate = -((get_local_mouse_position() - get_child(0).position)).x/20
	boxSpeed = (boxSpeed * rotationRate)/4

func _process(delta: float):
	if rotationRate != 0:
		get_child(1).rotation += rotationRate * delta 
	position.x += boxSpeed * delta 

func _exit_tree() -> void:
	Global._remove_box_from_scene(self)

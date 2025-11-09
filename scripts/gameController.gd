extends Node2D

# Box Textures:
@onready var fixedTextures = [preload("res://spirtes/BoxSprites/fixedBox.png"),
								preload("res://spirtes/BoxSprites/fixedBox2.png"),
								preload("res://spirtes/BoxSprites/fixedBox3.png"),
								preload("res://spirtes/BoxSprites/fixedBox4.png"),
								]
@onready var openedTextures = [preload("res://spirtes/BoxSprites/openedBox.png"),
								preload("res://spirtes/BoxSprites/openedBox2.png"),
								preload("res://spirtes/BoxSprites/openedBox3.png"),
								preload("res://spirtes/BoxSprites/openedBox4.png"),
								]
@onready var tapelessTextures = [preload("res://spirtes/BoxSprites/tapelessBox.png"),
								preload("res://spirtes/BoxSprites/tapelessBox2.png"),
								preload("res://spirtes/BoxSprites/tapelessBox3.png"),
								preload("res://spirtes/BoxSprites/tapelessBox4.png"),
								]
@onready var dirtyTextures = [preload("res://spirtes/BoxSprites/dirtyBox.png"),
								preload("res://spirtes/BoxSprites/dirtyBox2.png"),
								preload("res://spirtes/BoxSprites/dirtyBox3.png"),
								preload("res://spirtes/BoxSprites/dirtyBox4.png"),
								preload("res://spirtes/BoxSprites/dirtyBox5.png"),
								preload("res://spirtes/BoxSprites/dirtyBox6.png"),
								preload("res://spirtes/BoxSprites/dirtyBox7.png"),
								]
@onready var bulgingTextures = [preload("res://spirtes/BoxSprites/bulgingBox.png"),
								preload("res://spirtes/BoxSprites/bulgingBox2.png"),
								preload("res://spirtes/BoxSprites/bulgingBox3.png"),
								preload("res://spirtes/BoxSprites/bulgingBox4.png"),
								]
#@onready var fixedCrates = [preload("res://spirtes/BoxSprites/fixedCrate.png"),
								#
								#]
@onready var boltlessCrates = [preload("res://spirtes/BoxSprites/boltlessCrate.png"),
								preload("res://spirtes/BoxSprites/boltlessCrate2.png"),
								preload("res://spirtes/BoxSprites/boltlessCrate3.png"),
								preload("res://spirtes/BoxSprites/boltlessCrate4.png"),
								]
@onready var FixedLeftBolt = preload("res://spirtes/bolts/fixedLeftBolt.png")
#@onready var FixedRightBolt = preload("res://spirtes/bolts/fixedRightBolt.png")
@onready var LooseLeftBolts = [preload("res://spirtes/bolts/looseLeftBolt.png"),
								preload("res://spirtes/BoxSprites/bolts/looseLeftBolt2.png"),
								preload("res://spirtes/BoxSprites/bolts/looseLeftBolt3.png"),
								]
#@onready var LooseRightBolts = [preload("res://spirtes/bolts/looseRightBolt.png"),
								#preload(),
								#preload(),
								#preload(),
								#]

@onready var box = preload("res://scenes/boxes.tscn")
@onready var lights = preload("res://scenes/lightsOffEvent.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"
@onready var clockText: Label = $Clock
@onready var paused_screen: Panel = $PausedScreen
@onready var Score = $Score

var count = 0
var gameTime = 0
var hour = 9
var minute = 0
@onready var clock_animations: AnimationPlayer = $Clock/ClockAnimations

@onready var level_instruction_animations: AnimationPlayer = $levelInstructions/levelInstructionAnimations
@onready var level_complete_animations: AnimationPlayer = $levelComplete/levelCompleteAnimations
@onready var loading_screen_animator: AnimationPlayer = $LoadingScreen/loadingScreenAnimator

var gameIsStarted = false
var shiftIsOver = false
var paused = false
func _ready() -> void:
	ScoreController._reset_score()
	clockText.visible = false
	$Score.visible = false
	paused = !paused
	get_tree().paused = paused
	
	add_child(lights.instantiate())
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if !gameIsStarted:
			paused = false
			get_tree().paused = paused
			level_instruction_animations.play("InstructionExit")
			clockText.visible = true
			$Score.visible = true
			gameIsStarted = true
		elif shiftIsOver:
			loading_screen_animator.play("exitScene")
	elif event.is_action_pressed("pause") && !shiftIsOver:
		paused = !paused
		get_tree().paused = paused
		paused_screen.visible = paused
var runClock = false
var spawnBoxes = true
func _start_clock():
	runClock = true
func _second_passed():
	if !runClock:
		return
	# 1 Second = 5 minutes
	# 12 seconds = 1 hour
	# 96 seconds = 480 minutes
	#at 96, change timer to red, stop spawning boxes
	gameTime += 1
	$Timer.wait_time = 300.0/float(Global.currentBoxSpeed)
	@warning_ignore("integer_division")
	# Integer Division, 0.5 rounds down to 0
	minute = (gameTime/2)%6
	if (gameTime < 48):
		if (gameTime % 12 == 0):
			@warning_ignore("integer_division")
			hour = (9 + (gameTime*5)/60)
		if gameTime < 36:
			clockText.text = str(hour) + ":" + str(minute) + "0 AM"
		else:
			clockText.text = str(hour) + ":" + str(minute) + "0 PM"
	elif (gameTime < 96):
		if (gameTime % 12 == 0):
			@warning_ignore("integer_division")
			hour = (0 + (gameTime*5/60)-3)
		clockText.text = str(hour) + ":" + str(minute) + "0 PM"
	else:
		clock_animations.play("ShiftEnd")
		runClock = false
		spawnBoxes = false

var lastBoxSpawned = "Mislabeled"
var boxType 
func _on_timer_timeout() -> void:
	if spawnBoxes == false:
		if Global.boxesInScene == [] && !shiftIsOver:
			_shift_complete()
		return
	var boxInstance = box.instantiate()
	boxInstance.position = boxSpawner.position
	add_child(boxInstance)
	
	boxType = boxInstance.get_box_type()
	while lastBoxSpawned == "Mislabeled" && boxType == "Mislabeled":
		boxType = boxInstance.get_box_type()
	boxInstance.match_box(boxType)
	
	#print("box spawned in")
	if boxType != "Fixed Crate" && boxType != "Boltless" && boxType != "Loose Bolt":
		count += 1
	boxInstance.change_label(count)
	lastBoxSpawned = boxType
	#$Timer.start()

func _on_resume_button_pressed() -> void:
	paused = false
	get_tree().paused = paused
	paused_screen.visible = paused

func _on_main_menu_button_pressed() -> void:
	paused = false
	get_tree().paused = false
	loading_screen_animator.play("exitScene")
#used in animator
func _set_scene_to_title():
	get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _shift_complete() -> void:
	level_complete_animations.play("levelCompleteEnter")
	shiftIsOver = true
	Global._set_new_score(Score._get_current_score())
	clockText.visible = false
	$Score.visible = false
	paused = true
	get_tree().paused = paused
@onready var final_score: Label = $levelComplete/RichTextLabel/FinalScore
@onready var boxes_missed: Label = $levelComplete/RichTextLabel/BoxesMissed
func _set_final_score():
	
	final_score.text = str(Score._get_current_score())
func _set_boxes_missed():
	boxes_missed.text = str(Score._get_missed_boxes())

@onready var stars: Node2D = $levelComplete/Stars
func _try_set_star_visible(starIndex):
	var star = stars.get_child(starIndex)
	match starIndex:
		2:
			if Score._get_current_score() >= 4500:
				star.set_deferred("modulate",Color(1,1,1,1))
		1:
			if Score._get_current_score() >= 3500:
				star.set_deferred("modulate",Color(1,1,1,1))
		0:
			if Score._get_current_score() >= 3000:
				star.set_deferred("modulate",Color(1,1,1,1))
	

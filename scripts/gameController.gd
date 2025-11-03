extends Node2D

@onready var box = preload("res://scenes/boxes.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"
@onready var clockText: Label = $Clock
@onready var paused_screen: Panel = $PausedScreen


var count = 0
var gameTime = 0
var hour = 9
var minute = 0
@onready var clock_animations: AnimationPlayer = $Clock/ClockAnimations

@onready var level_instruction_animations: AnimationPlayer = $levelInstructions/levelInstructionAnimations
var gameIsStarted = false
var paused = false
func _ready() -> void:
	clockText.visible = false
	$Score.visible = false
	paused = !paused
	get_tree().paused = paused
func _input(event):
	if event is InputEventMouseButton and event.pressed && !gameIsStarted:
		paused = !paused
		get_tree().paused = paused
		level_instruction_animations.play("InstructionExit")
		clockText.visible = true
		$Score.visible = true
		gameIsStarted = true
	elif event.is_action_pressed("pause"):
		paused = !paused
		get_tree().paused = paused
		paused_screen.visible = paused
var startClock = false
var spawnBoxes = true
func _start_clock():
	startClock = true
func _second_passed():
	if !startClock:
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
		startClock = false
		spawnBoxes = false

func _on_timer_timeout() -> void:
	if spawnBoxes == false:
		if Global.boxesInScene == []:
			get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")
		return
	var boxInstance = box.instantiate()
	boxInstance.position = boxSpawner.position
	add_child(boxInstance)
	var boxType = boxInstance.get_box_type()
	boxInstance.match_box(boxType)
	
	#print("box spawned in")
	if boxType != "Fixed Crate" && boxType != "Boltless" && boxType != "Loose Bolt":
		count += 1
	boxInstance.change_label(count)
	$Timer.start()

func _on_resume_button_pressed() -> void:
	paused = false
	get_tree().paused = paused
	paused_screen.visible = paused

func _on_main_menu_button_pressed() -> void:
	paused = false
	get_tree().paused = paused
	get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

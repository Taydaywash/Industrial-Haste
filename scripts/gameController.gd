extends Node2D

@onready var box = preload("res://scenes/boxes.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"
@onready var clockText: Label = $Clock
@onready var paused_screen: Panel = $PausedScreen


var count = 0
var gameTime = 0
var hour = 9
var minute = 0

var paused = false
func _input(event):
	if event.is_action_pressed("pause"):
		paused = !paused
		get_tree().paused = paused
		paused_screen.visible = paused

func _second_passed():
	# 1 Second = 5 minutes
	# 12 seconds = 1 hour
	# 96 seconds = 480 minutes
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
		pass

func _on_timer_timeout() -> void:
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

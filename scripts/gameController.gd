extends Node2D

@onready var box = preload("res://scenes/boxes.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"
@onready var clockText: Label = $Clock
@onready var paused_screen: Panel = $PausedScreen


var count = 0
var gameTime = 0
var hour = 6
var minute = 0

var paused = false
func _input(event):
	if event.is_action_pressed("pause"):
		paused = !paused
		get_tree().paused = paused
		paused_screen.visible = paused

func _second_passed():
	# 30 seconds is 1 minute ingame
	gameTime += 2
	Global._change_box_speed_to(gameTime*10)
	$Timer.wait_time = 300.0/float(Global.currentBoxSpeed)
	
	if (gameTime >= 360):
		return
	if (gameTime % 60 == 0):
		@warning_ignore("integer_division")
		hour = (6 + gameTime/60)
	if (gameTime % 10 == 0):
		
		
		@warning_ignore("integer_division")
		minute = ((gameTime/10) - (6 * (hour - 6)))
	clockText.text = str(hour) + ":" + str(minute) + "0"

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

extends Node2D

@onready var box = preload("res://scenes/boxes.tscn")
@onready var boxSpawner : Node2D = $"BoxSpawner"

var count = 0
@onready var clockText: Label = $Clock
var gameTime = 0
var hour = 6
var minute = 0

func _second_passed():
	# 30 seconds is 1 minute ingame
	gameTime += 2
	
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
	boxInstance.match_box(boxInstance.get_box_type())
	#print("box spawned in")
	count += 1
	$Timer.start()

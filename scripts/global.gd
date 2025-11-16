extends Node

var cursor = preload("res://spirtes/handToolPalmCursorSmall.png")
var cursor2 = preload("res://spirtes/handToolGraspCursorSmall.png")

var levelScores: Array = [9999,9990,0,0,0,0,0,0,0]

var tool = 0
var boxesInScene: Array = []
var currentBoxSpeed = 150

func _ready():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			Input.set_custom_mouse_cursor(cursor2, Input.CURSOR_ARROW, Vector2(16, 16))
		else: 
			Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))


func _add_box_to_scene(box):
	boxesInScene.insert(0,box)
func _remove_box_from_scene(deletedBox):
	boxesInScene.remove_at(boxesInScene.find(deletedBox))
func _change_box_speed_to(speed):
	for box in boxesInScene:
		box._set_speed_to(speed)
		currentBoxSpeed = speed
func _set_tool_to(input):
	tool = input

func _get_tool():
	return tool

func _reset_tool():
	tool = 0

# Box Spawn Rates
var level = 0
func _set_level_to(number):
	level = number
func _set_new_score(score):
	if levelScores[level] < score:
		levelScores[level] = score


func _get_spawn_rates():
	var boxTypesForLevel: Dictionary
	match level:
		#4500 points
		#4000 points
		#3000 points
		0:
			boxTypesForLevel = {
			"Fixed": 10, 
			"Opened": 20, 
			"Tapeless": 30,
			"Dirty": 40, 
			"Mislabeled": 50, 
			"Bulging": 60, 
			"Fixed Crate": 70,
			"Loose Bolt": 80, 
			"Boltless": 100 
			}
		1:
			boxTypesForLevel = {
			"Fixed": 30, 
			"Opened": 65, 
			"Tapeless": 70,
			"Dirty": 85, 
			"Mislabeled": 90, 
			"Bulging": 100, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		2:
			boxTypesForLevel = {
			"Fixed": 30, 
			"Opened": 60, 
			"Tapeless": 65,
			"Dirty": 85, 
			"Mislabeled":90, 
			"Bulging": 100, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		3:
			boxTypesForLevel = {
			"Fixed": 25, 
			"Opened": 40, 
			"Tapeless": 50,
			"Dirty": 70, 
			"Mislabeled": 75, 
			"Bulging": 90, 
			"Fixed Crate": 95,
			"Loose Bolt": 100, 
			"Boltless": 0 
			}
		4:
			boxTypesForLevel = {
			"Fixed": 20, 
			"Opened": 25, 
			"Tapeless": 30,
			"Dirty": 45, 
			"Mislabeled": 55, 
			"Bulging": 75, 
			"Fixed Crate": 85,
			"Loose Bolt": 100, 
			"Boltless": 0 
			}
		5:
			boxTypesForLevel = {
			"Fixed": 10, 
			"Opened": 15, 
			"Tapeless": 20,
			"Dirty": 35, 
			"Mislabeled": 55, 
			"Bulging": 75, 
			"Fixed Crate": 85,
			"Loose Bolt": 95, 
			"Boltless": 100 
			}
		6:
			boxTypesForLevel = {
			"Fixed": 10, 
			"Opened": 15, 
			"Tapeless": 20,
			"Dirty": 35, 
			"Mislabeled": 55, 
			"Bulging": 70, 
			"Fixed Crate": 80,
			"Loose Bolt": 90, 
			"Boltless": 100 
			}
		7:
			boxTypesForLevel = {
			"Fixed": 10, 
			"Opened": 15, 
			"Tapeless": 20,
			"Dirty": 30, 
			"Mislabeled": 55, 
			"Bulging": 70, 
			"Fixed Crate": 80,
			"Loose Bolt": 90, 
			"Boltless": 100 
			}
		8:
			boxTypesForLevel = {
			"Fixed": 5, 
			"Opened": 15, 
			"Tapeless": 25,
			"Dirty": 40, 
			"Mislabeled": 50, 
			"Bulging": 60, 
			"Fixed Crate": 70,
			"Loose Bolt": 85, 
			"Boltless": 100 
			}
	return boxTypesForLevel

func _get_unsafe_discard_boxes():
	var unsafeBoxes: Array = []
	match level:
		0:
			unsafeBoxes = ["Loose Bolt","Boltless","Opened","Tapeless"]
		1:
			unsafeBoxes = [""]
	return unsafeBoxes

func _get_safe_boxes():
	var safeBoxes: Array = []
	match level:
		0:
			safeBoxes = ["Fixed","Fixed Crate"]
		1:
			safeBoxes = ["Fixed","Tapeless","Dirty","Mislabeled","Bulging"]
	return safeBoxes

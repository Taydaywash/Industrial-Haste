extends Node

var tool = 0
var boxesInScene: Array = []
var currentBoxSpeed = 150

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

func _get_spawn_rates():
	var boxTypesForLevel: Dictionary
	match level:
		0:
			boxTypesForLevel = {
			"Fixed": 10, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 50, 
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
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		3:
			boxTypesForLevel = {
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		4:
			boxTypesForLevel = {
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		5:
			boxTypesForLevel = {
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		6:
			boxTypesForLevel = {
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		7:
			boxTypesForLevel = {
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
		8:
			boxTypesForLevel = {
			"Fixed": 0, 
			"Opened": 0, 
			"Tapeless": 0,
			"Dirty": 0, 
			"Mislabeled": 0, 
			"Bulging": 0, 
			"Fixed Crate": 0,
			"Loose Bolt": 0, 
			"Boltless": 0 
			}
	return boxTypesForLevel

func _get_unsafe_discard_boxes():
	var unsafeBoxes: Array = []
	match level:
		0:
			unsafeBoxes = ["Loose Bolt"]
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

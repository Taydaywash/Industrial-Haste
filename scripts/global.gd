extends Node

var tool = 0

func _set_tool_to(input):
	print(input)
	tool = input

func _get_tool():
	return tool

func _reset_tool():
	tool = 0

# Box Spawn Rates
var level = 0
func _set_level_to(number):
	level = number
func _set_spawn_rates():
	var boxTypesForLevel: Dictionary
	match level:
		0:
			boxTypesForLevel = {
	"Fixed": 100, 
	"Opened": 0, 
	"Tapeless": 0,
	"Dirty": 0, 
	"Mislabeled": 0, 
	"Bulging": 0, 
	"Loose Bolt": 0, 
	"Boltless": 0 
	}
		1:
			boxTypesForLevel = {
	"Fixed": 0, 
	"Opened": 100, 
	"Tapeless": 0,
	"Dirty": 0, 
	"Mislabeled": 0, 
	"Bulging": 0, 
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
	"Loose Bolt": 0, 
	"Boltless": 0 
	}
	return boxTypesForLevel

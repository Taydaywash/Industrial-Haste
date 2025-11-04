extends Control
@onready var level_select_backdrop: Panel = $LevelSelectBackdrop

#Testing
func _on_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameScreen.tscn")

#Main Menu
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_level_select_button_pressed():
	for childIndex in range (0,8):
		for starIndex in range (0,3):
			var star = level_select_backdrop.get_child(0).get_child(childIndex).get_child(starIndex)
			match starIndex:
				2:
					if Global.levelScores[childIndex+1] >= 4500:
						star.visible = true
					else:
						star.visible = false
				1:
					if Global.levelScores[childIndex+1] >= 3500:
						star.visible = true
					else:
						star.visible = false
				0:
					if Global.levelScores[childIndex+1] >= 3000:
						star.visible = true
					else:
						star.visible = false
					
			
	level_select_backdrop.visible = true

#Level Select
func _on_level_select_back_button_pressed():
	level_select_backdrop.visible = false

func _on_level_button_pressed(level):
	Global._set_level_to(level)
	get_tree().change_scene_to_file("res://scenes/Levels/Level"+str(level)+".tscn")

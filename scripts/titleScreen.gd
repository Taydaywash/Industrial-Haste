extends Control
@onready var level_select_backdrop: Panel = $LevelSelectBackdrop

#Testing
func _on_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameScreen.tscn")

#Main Menu
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_level_select_button_pressed():
	level_select_backdrop.visible = true

#Level Select
func _on_level_select_back_button_pressed():
	level_select_backdrop.visible = false

func _on_level_button_pressed(level):
	Global._set_level_to(level)
	get_tree().change_scene_to_file("res://scenes/Levels/Level"+str(level)+".tscn")

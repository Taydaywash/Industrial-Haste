extends Control

#Main Menu
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
#Level Select
func _on_level_select_button_pressed():
	get_tree().change_scene_to_file("res://scenes/GameScreen.tscn")

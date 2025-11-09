extends Control
@onready var level_select_backdrop: Panel = $LevelSelectBackdrop

func _ready() -> void:
	get_tree().paused = false

func _process(delta: float) -> void:
	for i in range(0,5):
		$backgroundDecorations.get_child(i).rotation += delta
	@warning_ignore("integer_division")
	$TItleBackgroundOverlay/TitleBackground.position = get_global_mouse_position()/500 + Vector2(576,328)
	$backgroundDecorations/titleIcon.rotation = get_global_mouse_position().x/100000

#Testing
func _on_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameScreen.tscn")


#Level Select
func _on_level_select_back_button_pressed():
	level_select_backdrop.visible = false

var levelSceneReference
@onready var loading_screen_animator: AnimationPlayer = $loadingScreenAnimator

func _on_level_button_pressed(level):
	Global._set_level_to(level)
	levelSceneReference = "res://scenes/Levels/Level"+str(level)+".tscn"
	loading_screen_animator.play("exitScene")

func _load_scene():
	get_tree().change_scene_to_file(levelSceneReference)

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

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

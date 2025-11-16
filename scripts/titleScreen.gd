extends Control
@onready var level_select_backdrop: Panel = $LevelSelectBackdrop
@onready var setting_menu: Panel = $SettingMenu
@onready var quit_confirm: Panel = $QuitConfirm

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
func _on_level_select_button_pressed():
	for childIndex in range (0,8):
		if childIndex < 7:
			if Global.levelScores[childIndex] >= 3000:
				level_select_backdrop.get_child(1).get_child(childIndex).visible = true
			else:
				level_select_backdrop.get_child(1).get_child(childIndex).visible = false
		else:
			var threeStarsInAll = true
			for score in range (0,8):
				if Global.levelScores[score] < 3500:
					threeStarsInAll = false
			print(threeStarsInAll)
			if threeStarsInAll:
				level_select_backdrop.get_child(1).get_child(childIndex).visible = true
			else:
				level_select_backdrop.get_child(1).get_child(childIndex).visible = false
		for starIndex in range (0,3):
			var star = level_select_backdrop.get_child(1).get_child(childIndex).get_child(starIndex)
			
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
	setting_menu.visible = true
func _on_settings_back_button_pressed() -> void:
	setting_menu.visible = false

func _on_quit_button_pressed() -> void:
	quit_confirm.visible = true
func _on_quit_confirm_pressed() -> void:
	get_tree().quit()
func _on_quit_cancel_pressed() -> void:
	quit_confirm.visible = false

@onready var volume_number: Label = $SettingMenu/MasterVolumeText/volumeNumber
func _on_master_volume_text_value_changed(value: float) -> void:
	SoundManager. play_bolt_placed_sound()
	SoundManager.set_master_volume_to(value)
	
	volume_number.text = str(int(value*100))

@onready var sfx_number: Label = $"SettingMenu/SFX Volume/SFXNumber"
func _on_sfx_volume_value_changed(value: float) -> void:
	SoundManager. play_bolt_placed_sound()
	SoundManager.set_sfx_volume_to(value)
	sfx_number.text = str(int(value*100))

@onready var music_number: Label = $"SettingMenu/Music Volume/musicNumber"
func _on_music_volume_value_changed(value: float) -> void:
	SoundManager. play_bolt_placed_sound()
	SoundManager.set_music_volume_to(value)
	music_number.text = str(int(value*100))

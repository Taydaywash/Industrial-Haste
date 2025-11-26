extends Panel
@onready var loading_screen_animator: AnimationPlayer = $"../LoadingScreen/loadingScreenAnimator"
var paused = false
@onready var gameScreen: Node2D = $".."

#func _input(event):
	#if event.is_action_pressed("pause"):
		#paused = !paused
		#get_tree().paused = paused
		#visible = paused

func _on_main_menu_button_pressed() -> void:
	paused = false
	get_tree().paused = false
	loading_screen_animator.play("exitScene")

func _on_resume_button_pressed() -> void:
	gameScreen.flip_pause_status()

var sceneTo
func _on_restart_button_pressed() -> void:
	gameScreen.set_next_screen_to_load_to( "res://scenes/Levels/Level"+str(Global.level)+".tscn")
	if Global.level == 0:
		gameScreen.set_next_screen_to_load_to("res://scenes/GameScreen.tscn")
	loading_screen_animator.play("exitScene")

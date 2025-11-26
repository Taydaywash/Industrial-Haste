extends Panel
@onready var loading_screen_animator: AnimationPlayer = $"../LoadingScreen/loadingScreenAnimator"
var paused = false
@onready var gameScreen: Node2D = $".."

func _on_main_menu_button_pressed() -> void:
	SoundManager.stop_ambience()
	paused = false
	get_tree().paused = false
	gameScreen.set_next_screen_to_load_to("res://scenes/TitleScreen.tscn")
	loading_screen_animator.play("exitScene")
func _on_resume_button_pressed() -> void:
	gameScreen.flip_pause_status()
var sceneTo
func _on_restart_button_pressed() -> void:
	SoundManager.stop_ambience()
	gameScreen.set_next_screen_to_load_to( "res://scenes/Levels/Level"+str(Global.level)+".tscn")
	if Global.level == 0:
		gameScreen.set_next_screen_to_load_to("res://scenes/GameScreen.tscn")
	loading_screen_animator.play("exitScene")

@onready var help_book_animator: AnimationPlayer = $HelpBookAnimator
func _play_sliding_book_sfx():
	SoundManager.play_sliding_book()
func _play_sliding_paper():
	SoundManager.play_sliding_paper()

var hoverableBook = true
func _on_help_book_collider_mouse_entered() -> void:
	if hoverableBook:
		help_book_animator.play("bookHoverUp")
func _on_help_book_collider_mouse_exited() -> void:
	if hoverableBook:
		help_book_animator.play("bookHoverDown")

func _on_help_book_collider_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		hoverableBook = false
		help_book_animator.play("openBook")

func _on_back_button_pressed() -> void:
	hoverableBook = true
	help_book_animator.play("closeBook")

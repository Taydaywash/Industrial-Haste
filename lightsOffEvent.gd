extends Node2D

@onready var light: Control = $"HangingLight"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var count = 0
var target

func _ready():
	animation_player.play("Swinging_Light")
	
	randomize()
	target = randi_range(1, 4)

func add_count():
	count += 1
	
func check_count():
	if count >= target:
		queue_free()

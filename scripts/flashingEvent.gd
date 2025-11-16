extends Node2D

@onready var flash: Panel = $"FlashingOverlay"

var spawn_chance = 500 #Global.flashingEventRarity[Global.level]
var seconds = 0


func _ready():
	pass

func flash_pulse():
	var tween = create_tween()
	tween.tween_property(flash, "self_modulate:a", 0.5, 1.0)
	tween.tween_property(flash, "self_modulate:a", 1.0, 1.0)

func _on_timer_timeout():
	randomize()
	seconds += 1
	if seconds%15 == 0:
		if randi_range(1, 100) <= spawn_chance:
			spawn_chance = Global.flashingEventRarity[Global.level]
			flash.visible = true
			$Timer.start()
		else:
			spawn_chance *= 1.1

func _on_timer_timeout_flashing():
	flash.visible = false
	spawn_chance = Global.flashingEventRarity[Global.level]

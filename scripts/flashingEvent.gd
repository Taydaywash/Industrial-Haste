extends Node2D

@onready var flash: Panel = $"FlashingOverlay"

var spawn_chance = Global.flashingEventRarity[Global.level]
var seconds = 0

func _ready():
	pass

func flash_pulse():
	var tween = create_tween()
	tween.tween_property(flash, "self_modulate:a", 0.5, 0.5)
	tween.tween_property(flash, "self_modulate:a", 0.9, 0.5)

func _on_timer_timeout():
	randomize()
	seconds += 1
	if seconds%15 == 0:
		if randi_range(1, 100) <= spawn_chance:
			spawn_chance = Global.flashingEventRarity[Global.level]
			flash.visible = true
			$Timer.start()
		else:
			spawn_chance *= 1.5
	
	if not $Timer.is_stopped():
		flash_pulse()

func _on_timer_timeout_flashing():
	spawn_chance = Global.flashingEventRarity[Global.level]
	var tween = create_tween()
	tween.tween_property(flash, "self_modulate:a", 0, 1)
	await get_tree().create_timer(1.0).timeout
	flash.visible = false
	

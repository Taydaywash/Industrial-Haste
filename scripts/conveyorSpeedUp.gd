extends Node2D

var defaultBoxSpeed
func _ready() -> void:
	defaultBoxSpeed = Global.boxSpeeds[Global.level]
@onready var wind_particle: CPUParticles2D = $windParticle

func _process(delta: float) -> void:
	if (Global.currentBoxSpeed > 290):
		wind_particle.visible = true
	else:
		wind_particle.visible = false
	wind_particle.color.a = Global.currentBoxSpeed/100.0 - 2.6
	wind_particle.initial_velocity_max = Global.currentBoxSpeed - 100
	wind_particle.initial_velocity_min = (Global.currentBoxSpeed/2.0) - 100
	for i in range(0,15):
		if i%2 == 0:
			get_child(1).get_child(1+i).rotation += Global.currentBoxSpeed * delta * 0.01
		else:
			get_child(1).get_child(1+i).rotation -= Global.currentBoxSpeed * delta * 0.01

func _on_tool_used(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var tool = Global._get_tool()
	#Mouse Up
	if event is InputEventMouseButton and !event.pressed:
		if tool == 2:
			SoundManager.play_bolt_screwed_sound()
			$"..".change_timer(Global.currentBoxSpeed,defaultBoxSpeed,$"../Timer".time_left)
			Global._change_box_speed_to(defaultBoxSpeed)
	SoundManager.dynamic_music(Global.currentBoxSpeed)

#increases every second
var fiveMinutes = 0
func _on_clock_timer_timeout() -> void:
	fiveMinutes+=1
	
	if Global.level >= 4 || Global.level == 0:
		if Global.level == 4:
			if fiveMinutes > 60 && fiveMinutes % (3) == 0:
				$"..".change_timer(Global.currentBoxSpeed,Global.currentBoxSpeed + (20),$"../Timer".time_left)
				Global._change_box_speed_to(Global.currentBoxSpeed + (20))
		elif fiveMinutes % (3) == 0:
			$"..".change_timer(Global.currentBoxSpeed,Global.currentBoxSpeed + 20,$"../Timer".time_left)
			Global._change_box_speed_to(Global.currentBoxSpeed + (20))
	SoundManager.dynamic_music(Global.currentBoxSpeed)

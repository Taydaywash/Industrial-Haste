extends Node2D

var defaultBoxSpeed
func _ready() -> void:
	defaultBoxSpeed = Global.boxSpeeds[Global.level]

func _process(delta: float) -> void:
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
			Global._change_box_speed_to(defaultBoxSpeed)

#increases every second
var fiveMinutes = 0
func _on_clock_timer_timeout() -> void:
	fiveMinutes+=1
	if Global.level >= 4 || Global.level == 0:
		if Global.level == 4:
			if fiveMinutes > 70 && fiveMinutes % (3) == 0:
				Global._change_box_speed_to(Global.currentBoxSpeed + (Global.currentBoxSpeed * 0.1))
		elif fiveMinutes % (3) == 0:
			Global._change_box_speed_to(Global.currentBoxSpeed + (Global.currentBoxSpeed * 0.1))

extends Node2D

@onready var light: Control = $"HangingLight"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var light_switch_texture: Sprite2D = $LightSwtichBar/Area2D/LightSwtich

var count = 0
var target
var chance = Global.lightEventRarity[Global.level]
var spawn_chance = chance
var seconds = 0

var switchOn = true
const switch_off = preload("res://spirtes/LightSwitchOff.png")
const switch_on = preload("res://spirtes/LightSwitchOn.png")

func _ready():
	set_target()

func start_light_swinging():
	animation_player.play("Swinging_Light")

func set_target():
	
	randomize()
	target = randi_range(2, 4)

func check_count():
	print(count)
	if count >= target:
		SoundManager.stop_ambience()
		light.visible = false

func _play_ambience():
	SoundManager.play_lights_off_ambience()

func _on_light_swtich_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		SoundManager.play_lights_switch_clicked()
		switchOn = !switchOn
		if switchOn:
			light_switch_texture.texture = switch_on
			count += 1
			check_count()
		else:
			light_switch_texture.texture = switch_off
			self.visible = true

func _on_timer_timeout():
	randomize()
	seconds += 1
	if seconds % 10 == 0:
		if randi_range(1, 100) <= spawn_chance:
			set_target()
			animation_player.play("lightsOff")
			count = 0
			spawn_chance = Global.lightEventRarity[Global.level]
			light.visible = true
		else:
			spawn_chance += chance * 2

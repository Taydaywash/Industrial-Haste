extends Node2D

@onready var light: Control = $"HangingLight"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var count = 0
var target

var switchOn = true
const LIGHT_SWITCH_OFF = preload("res://spirtes/LightSwitchOff.png")
const LIGHT_SWITCH_ON = preload("res://spirtes/LightSwitchOn.png")
@onready var light_swtich: Sprite2D = $"../LightSwtichBar/LightSwtich/LightSwtich"


func _ready():
	animation_player.play("Swinging_Light")
	
	randomize()
	target = randi_range(1, 4)

func add_count():
	count += 1
	
func check_count():
	if count >= target:
		queue_free()


func _on_light_swtich_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		switchOn = !switchOn
		if switchOn:
			light_swtich.texture = LIGHT_SWITCH_ON
			add_count()
		else:
			light_swtich.texture = LIGHT_SWITCH_OFF
			self.visible = true
		check_count()

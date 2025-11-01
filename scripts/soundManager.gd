extends Control

func play_whoosh_sound():
	randomize()
	$SoundWhoosh.pitch_scale = randf_range(.8, 1.2)
	$SoundWhoosh.play()

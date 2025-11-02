extends Control

func play_whoosh_sound():
	randomize()
	$SoundWhoosh.pitch_scale = randf_range(.8, 1.2)
	$SoundWhoosh.play()

func play_bolt_placed_sound():
	randomize()
	$SoundBoltPlaced.pitch_scale = randf_range(.9, 1.1)
	$SoundBoltPlaced.play()
	
func play_bolt_screwed_sound():
	randomize()
	$SoundBoltScrewed.pitch_scale = randf_range(.8, 1.2)
	$SoundBoltScrewed.play()

func play_poof_sound():
	randomize()
	$SoundPoof.pitch_scale = randf_range(.8, 1.4)
	$SoundPoof.play()
	
func play_tape_placed_sound():
	randomize()
	$SoundTapePlaced.pitch_scale = randf_range(.8, 1.2)
	$SoundTapePlaced.play()

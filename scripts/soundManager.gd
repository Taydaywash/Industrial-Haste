extends Control

func set_master_volume_to(value):
	AudioServer.set_bus_volume_linear(0,value)
func set_sfx_volume_to(value):
	AudioServer.set_bus_volume_linear(1,value)
func set_music_volume_to(value):
	AudioServer.set_bus_volume_linear(2,value)
	
func play_lights_off_ambience():
	randomize()
	$LightsOffAmbience.pitch_scale = randf_range(.8, 1.2)
	$LightsOffAmbience.play()
func stop_ambience():
	$PowerOff.stop()
	$LightsOffAmbience.stop()

func play_light_flicker():
	randomize()
	$LightOnFlicker.pitch_scale = randf_range(.8, 1.2)
	$LightOnFlicker.play()

func play_sliding_paper():
	randomize()
	$SlidingPaper.pitch_scale = randf_range(.8, 1.2)
	$SlidingPaper.play()

func play_sliding_book():
	randomize()
	$SlidingBook.pitch_scale = randf_range(.8, 1.2)
	$SlidingBook.play()

func play_lights_switch_clicked():
	randomize()
	$LightSwitchClicked.pitch_scale = randf_range(.8, 1.2)
	$LightSwitchClicked.play()

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
	
func play_transition_sound():
	randomize()
	$ScreenTransition.pitch_scale = randf_range(0.6, 0.85)
	$ScreenTransition.play()
	
func play_hover_sound():
	randomize()
	$Hover.pitch_scale = randf_range(.8, 1.2)
	$Hover.play()
	
func play_paper_hover_sound():
	randomize()
	$PaperHover.pitch_scale = randf_range(1.2, 1.6)
	$PaperHover.play()
	
func play_clocking_in_hot():
	$WelcomeToFactoryTown.stop()
	$ClockingInHot.play()
	$ClockingInHot.volume_db = -80.0
	$SimulationAnxiety.play()
	$SimulationAnxiety.volume_db = -15.0
func dynamic_music(speed):
	if speed <= 290.0:
		$ClockingInHot.volume_db = -80.0
		$SimulationAnxiety.volume_db = -15.0
	else:
		$ClockingInHot.volume_db = -15.0
		$SimulationAnxiety.volume_db = -80.0
	
func play_welcome_to_factory_town():
	$ClockingInHot.stop()
	$SimulationAnxiety.stop()
	$WelcomeToFactoryTown.play()
	
func play_button_clicked():
	randomize()
	$ButtonClick.pitch_scale = randf_range(.8, 1.2)
	$ButtonClick.play()

func play_stars(num):
	$Stars.pitch_scale = num
	$Stars.play()

func play_ticking():
	randomize()
	$Ticking.pitch_scale = randf_range(.9, 1.1)
	$Ticking.play()

func play_zero_stars():
	$ZeroStars.play()
	
func play_one_star():
	$OneStar.play()
	
func play_two_stars():
	$TwoStars.play()
	
func play_three_stars():
	$ThreeStars.play()

func play_tool_grab():
	randomize()
	$ToolGrab.pitch_scale = randf_range(.8, 1.2)
	$ToolGrab.play()

func play_siren():
	$Siren.play()
	
func end_siren():
	$Siren.stop()
	
func play_gain_points():
	$GainPoints.play()
	
func play_loose_points():
	$LoosePoints.play()
func play_power_off():
	$PowerOff.play()
func play_power_on():
	$PowerOn.play()

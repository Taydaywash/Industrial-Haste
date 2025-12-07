extends RichTextLabel
const LEVEL_1_TEXT = "1. Discard opened Boxes"
const LEVEL_2_TEXT = "1. Discard opened Boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out"
const LEVEL_3_TEXT = "1. Tape up opened and tapeless boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out"
const LEVEL_4_TEXT = "1. Tape up opened and tapeless boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out
4. Discard misshapened boxes"
const LEVEL_5_TEXT = "1. Tape up opened and tapeless boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out
4. Discard misshapened boxes
5. Repair crates with loose bolts
6. Tighten conveyor belt gears"
const LEVEL_6_TEXT = "1. Tape up opened and tapeless boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out
4. Discard misshapened boxes
5. Repair crates with loose bolts
6. Discard crates missing bolts
7. Tighten conveyor belt gears"
const LEVEL_7_TEXT = "1. Tape up opened and tapeless boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out
4. Discard misshapened boxes
5. Repair crates with loose bolts, add bolts to crates with none
6. Tighten conveyor belt gears
7. Discard mislabled boxes"
const LEVEL_8_TEXT = "1. Tape up opened and tapeless boxes
2. Discard dirty-looking boxes
3. Flick the light switch if lights go out
4. Discard misshapened boxes
5. Repair crates with loose bolts, add bolts to crates with none
6. Tighten conveyor belt gears
7. Discard mislabled boxes"
func get_level_text(level:int):
	match level:
		0:
			return LEVEL_1_TEXT
		1:
			return LEVEL_1_TEXT
		2:
			return LEVEL_2_TEXT
		3:
			return LEVEL_3_TEXT
		4:
			return LEVEL_4_TEXT
		5:
			return LEVEL_5_TEXT
		6:
			return LEVEL_6_TEXT
		7:
			return LEVEL_7_TEXT
		8:
			return LEVEL_8_TEXT
	

extends Label

var score = 0
var boxesMissed = 0
#Adding points to the score
func _reset_score():
	score = 0
	boxesMissed = 0
func _add_points(points):
	self.get_child(0).play("_score_gain")
	score = score + points
	self.text = "Score: " + str(score)

#Subtracting points from the score
func _subtract_points(points):
	boxesMissed += 1
	self.get_child(0).play("_score_loss")
	if score - points > 0:
		score = score - points
		self.text = "Score: " + str(score)
	else:
		score = 0
		self.text = "Score: " + str(score)

func _get_current_score():
	return score
func _get_missed_boxes():
	return boxesMissed

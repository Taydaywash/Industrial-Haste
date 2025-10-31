extends Label

var score = 0

#Adding points to the score
func add_points(points):
	self.get_child(0).play("_score_gain")
	score = score + points
	self.text = "Score: " + str(score)

#Subtracting points from the score
func subtract_points(points):
	self.get_child(0).play("_score_loss")
	if score - points > 0:
		score = score - points
		self.text = "Score: " + str(score)
	else:
		score = 0
		self.text = "Score: " + str(score)

extends Label

var score = 0

#Adding points to the score
func add_points(points):
	score = score + points
	self.text = "Score: " + str(score)

#Subtracting points from the score
func subtract_points(points):
	score = score - points
	self.text = "Score: " + str(score)

import "geometry.td"
#Donald Pomeroy
#Ben draws a circle inside a square piece of paper whose area is 400 square inches.
#He makes sure than the circle touches each side of the square.
#What is the area of the circle?

node Solve_question2(area)
	radius = (area**(0.5))/2 
	return Circle_area radius
end

Solve_question2 400 | Print

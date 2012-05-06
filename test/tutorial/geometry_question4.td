import "geometry.td"

#Donald Pomeroy
#A piece of square paper has a perimeter of 32 centimeters.
#Nicky's dog, Rocky, tore off 1/4 of the paper.
#What is the area of the remaining paper?

node Solve_question4(perimeter, loss)	
	area =  Square_area (perimeter / 4.0)
	return area - (loss * area)
end

Solve_question4 32 (1.0/4.0) | Print

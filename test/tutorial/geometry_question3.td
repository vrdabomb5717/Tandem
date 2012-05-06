import "geometry.td"
#Donald Pomeroy
#A length of wire is cut into several smaller pieces.
#Each of the smaller pieces are bent into squares.
#Each square has a side that measures 2 centimeters.
#The total area of the smaller squares is 92 square centimeters.
#What was the original length of wire?

node Solve_question3(total_area, side)
	num_squares = total_area / (Square_area side)
	return num_squares * (Square_perimeter side)
end

Solve_question3 92 2 | Print



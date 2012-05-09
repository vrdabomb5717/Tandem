import "geometry.td"

#"You have an 10 by 10 rubiks cube You paint the outside. How many cubes have paint on them?"
#Donald Pomeroy

node Solve_question1(side_len)
	return (Cube_Volume side_len) - ((side_len-2)**3)
end

Solve_question1 10 | Println



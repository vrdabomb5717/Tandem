
node Hypotenuse_length(leg1, leg2)
	temp1 = leg1**2 + leg1**2 
	return temp1**(0.5)
end

node Circle_area(radius)
	return (PI * (radius**2))
end

node Square_area(side_len)
	return side_len * side_len
end

node Cylinder_volume(radius, height)
	return (Circle_area radius)*height
end

node Cube_Volume(side_len)
	return side_len ** 3
end

node Cone_Volume(radius, height)
	return (1/3)*(Circle_area radius)*height
end

node Cube_surface_area(side_len)
	return (Square_area side_len)*6
end

node Cylinder_surface_area(radius,height)
	return 2*(PI*(radius**2)) + (2*PI*r*h) 
end

node Sphere_surface_area(radius)
	return 4*(Circle_area radius)
end

node Sphere_volume(radius)
	return (4/3)*(Circle_area radius)*(radius)
end

node Cone_surface_area(height,radius)
	PI * radius * (Hypotenuse_length height radius) * (Circle_area radius)   
end

node Rectangular_prism_volume(length,width,height)
	return length*width*height
end

node Rectangular_prism_surface_area(length,width,height)
	return (2*(length*width)) + (2*(length*height))+(2*(height*width))
end

node Trapezoid_area (base1,base2,height)
	return (1/2)*(base1 + base2)*height
end

node Trapezoidal_prism_volume(base1,base2,baseHeight,height)
	return height * (Trapezoid_area base1 base2 baseHeight)
end

node Triangle_area(base, height)
	return (1/2)*(base*height)
end

node Regular_pentagon_area(side_length)
	return (side_length**2)*1.7
end

node Regular_hexagon_area(side_length)
	return (side_length**2)*2.6
end

node Regular_octagon(side_length)
	return (side_length**2)*4.84
end

node Regular_icosahedron_volume(side_length)
	return (side_length**3)*2.18
end

node Regular_icosahedron_surface_area(side_length)
	return 8.66*(side_length**2)
end

node Torus_volume(minorRadius,majorRadius)
	return 2*PI*majorRadius * (Circle_area minorRadius)
end

node Torus_surface_area(minorRadius,majorRadius)
	return (2*PI*minorRadius)*(2*PI*majorRadius)
end

node Regular_tetrahedron_volume(side_length)
	return (2**(1/2))*(1/12)*(side_length**3)
end

node Regular_tetrahedron_surface_area(side_length)
	return (3**(1/2))*(side_length**2)
end 

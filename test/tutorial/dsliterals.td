require "set"
node DSLiterals()
	node MakeList()
		a = [1,3,5,7,9,9]
		element = a[0] # element is equal to 1
	end

	node MakeSet()
		a = Set.new 0 2 4 6 8
		anotherElement = a[3] # anotherElement is equal to 6
	end

	finished = true
end
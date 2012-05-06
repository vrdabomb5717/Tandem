node Fibonacci(input)
	node Iterative(number)
		prev1 = 0
		prev2 = 1

		for x in 0..number
			savePrev1 = prev1
			prev1 = prev2
			prev2 = savePrev1 + prev2
		end

		return prev1
	end

	node Recursive(number)
		if number < 2
			return number
		else
			(Recursive number-1) + (Recursive number-2)
		end
	end

	Iterative input
	Recursive input
end
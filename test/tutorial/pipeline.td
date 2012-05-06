import "Fibonacci.td"

public node N()
	node F(x)
		x+1
	end

	node G(x)
		x
	end

	cond
		a > 0
			F a | Recursive | Print
		true
			G a | Iterative | Print
		end
	end
end
import "Fibonacci.td"

public Node N()
	node F(x)
		x+1
	end

	cond
		a > 0
			F a | Recursive | Print
		true
			G a | Iterative | Print
		end
	end

	node G(x)
		x
	end
end
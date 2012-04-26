node node1(a, b)
	cond
		a>b
			x=a+b
			node2 x
		end
		b>a
			y=b-a
			node3 b
		end
		a==b
			node4 a b    
     
			x=y=z=1

		end
	end
	node node2(greaterA)
		print "I am at node2"
		greaterA-4
	end
	node node3(greaterB)
		answer =greaterB-8
		node4 answer greaterB | node2 
		a|b|c|d|e|f
	end
	node node4(myA, myB)
		a = myA *5
		b = myB -5
		node5 a b
		node node5(g,h)
			sum = "I am at node 5"
			print sum
		end
	end
end


node Node1(a, b)
	cond
		a>b
			x=a+b
			Node2 x
		end
		b>a
			y=b-a
			Node3 b
		end
		a==b
			Node4 a b    
     
			x=y=z=1

		end
	end
	node Node2(greaterA)
		Print "I am at node2"
		greaterA-4
	end
	node Node3(greaterB)
		answer =greaterB-8
		Node4 answer greaterB | Node2 
		A|B|C|D|E|F
	end
	node Node4(myA, myB)
		a = myA *5
		b = myB -5
		Node5 a b
		node Node5(g,h)
			sum = "I am at node 5"
			Print sum
		end
	end
end


node Node1(a, b)
2	  	
  cond
3	  	
    a>b
4	  	
-      x=a+b
5	  	
      Node2 x
6	  	
    end
7	  	
    b>a
8	  	
      y=b-a
9	  	
      Node3 b
10	  	
    end
11	  	
    a==b
12	  	
      Node4 a b    
13	  	
     
14	  	
      x=y=z=1
15	  	

16	  	
    end
17	  	
  end
18	  	
  node Node2(greaterA)
19	  	
    Print "I am at node2"
20	  	
    greaterA-4
21	  	
  end
22	  	
  node Node3(greaterB)
23	  	
    answer =greaterB-8
24	  	
    Node4 answer greaterB | Node2 
25	  	
    A|B|C|D|E|F
26	  	
  end
27	  	
  node Node4(myA, myB)
28	  	
    a = myA *5
29	  	
    b = myB -5
30	  	
    Node5 a b
31	  	
    node Node5(g,h)
32	  	
      sum = "I am at node 5"
33	  	
      Print sum
34	  	
    end
35	  	
  end
36	  	
end
37	  	


node Hello2()
	node MyWords(text)
		return text
	end

	MyWords "Hello, World!" | Println
end

Hello2
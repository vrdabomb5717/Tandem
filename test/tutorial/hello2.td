node Hello2()
	node MyWords(text)
		return text
	end

	MyWords “Hello, World!” | print
end

Hello2
node Bit0(d)
	cond
		d = 0
			return 0
		end

		d = 1
			return 1
		end
	end
end

node Bit1(d)
	cond
		d = 0
			return 0
		end

		d = 1
			return 1
		end
	end
end

node Bit2(d)
	cond
		d = 0
			return 0
		end

		d = 1
			return 1
		end
	end
end

node Bit3(d)
	cond
		d = 0
			return 0
		end

		d = 1
			return 1
		end
	end
end

Bit0 1 | Bit1 | Bit2 | Bit3 | Println
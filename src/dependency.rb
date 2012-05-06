#! /usr/bin/env ruby
#Donald Pomeroy
require "set"
require 'pathname'


dependency_q = []
dependency_set =  Set.new
file = ARGV[0]
dir = ARGV[1]
#puts "flag 1 " + file
#puts "flag 2 " + dir
dependency_set << file


split_arr = ARGV[0].split(%r{\/})
split_arr.pop

path_to_dir=""

split_arr.each do|n|
   path_to_dir += n+"/"
end

#puts "flag 5" + path_to_dir

Dir.chdir(path_to_dir)
	
def dep_helper(d_q,d_set, d_file) 
	dependency_array = File.open(d_file, "r").grep(/import\s+\".*.td\"/) 
	x = []
	dependency_array.each do |y|
		y = y.chomp 
		t = y.split(%r{\s+})[1]
		x << t[1..(t.size-2)]	
		d_q.unshift t[1..(t.size-2)] if not d_set.include?(t[1..(t.size-2)])	
		d_set << t[1..(t.size-2)]
	end
end


dep_helper(dependency_q, dependency_set,file)

while(dependency_q.size != 0) do
	#puts Dir.getwd
	puts  dependency_q.last
	path = Pathname.new(dependency_q.last)
	#puts path
	#puts " flag 4 "+ File.absolute_path(dependency_q.last)
       # puts (Dir.getwd + "/"+dependency_q.last)
	#puts File.dirname( dependency_q.last)
	dep_helper(dependency_q, dependency_set,dependency_q.pop)
end
	

#get first file, add to q and add to set, call dep_help on the front of q until is empty, if d_set doesn't contain add to list

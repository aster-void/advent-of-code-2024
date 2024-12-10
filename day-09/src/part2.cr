require "./day9"

file = ARGV[0]
content = File.read file
puts Day9.part2 content

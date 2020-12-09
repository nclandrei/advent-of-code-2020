# frozen_string_literal: true

values = []
File.readlines('input.txt').each do |line|
  values.push(line.chars.map { |char| char == '.' ? 0 : 1 })
end

x = 0
y = 0
line_length = values[0].length
tree_count = 0

while y < values.length
  tree_count += 1 if values[y][x % (line_length - 1)] == 1

  x += 3
  y += 1
end

puts tree_count

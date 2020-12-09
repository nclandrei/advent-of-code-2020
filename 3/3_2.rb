# frozen_string_literal: true

values = []
File.readlines('input.txt').each do |line|
  values.push(line.chars.map { |char| char == '.' ? 0 : 1 })
end

def trees_for_slope(values, right, down)
  x = 0
  y = 0
  tree_count = 0
  line_length = values[0].length

  while y < values.length
    tree_count += 1 if values[y][x % (line_length - 1)] == 1

    x += right
    y += down
  end

  tree_count
end

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
tree_multiplication = 1

slopes.each do |right, down|
  tree_multiplication *= trees_for_slope(values, right, down)
end

puts tree_multiplication





# frozen_string_literal: true

ROW_COUNT = 128
COLUMN_COUNT = 8

class Seat
  def initialize(cipher)
    @cipher = cipher
  end

  def row_number
    min_row = 0
    max_row = ROW_COUNT
    row_cipher = @cipher[0..7]

    row_cipher.chars.each do |char|
      max_row -= (max_row - min_row) / 2 if char == 'F'
      min_row += (max_row - min_row) / 2 if char == 'B'
    end

    min_row
  end

  def column_number
    min_column = 0
    max_column = COLUMN_COUNT
    row_cipher = @cipher[7..10]

    row_cipher.chars.each do |char|
      max_column -= (max_column - min_column) / 2 if char == 'L'
      min_column += (max_column - min_column) / 2 if char == 'R'
    end

    min_column
  end

  def seat_id
    row_number * 8 + column_number
  end
end

max_seat_id = 0
File.readlines('input.txt').each do |line|
  seat_id = Seat.new(line).seat_id
  max_seat_id = seat_id if max_seat_id < seat_id
end

puts "Maximum seat ID is: #{max_seat_id}"

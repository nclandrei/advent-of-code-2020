# frozen_string_literal: true

# Password defines a password and the policy it must conform to.
class Password
  def initialize(first_index, second_index, char, password)
    @first_index = first_index
    @second_index = second_index
    @char = char
    @password = password
  end

  def valid?
    @password.count(@char) >= @first_index and @password.count(@char) <= @second_index
  end

  def new_policy_valid?
    (@password[@first_index - 1] == @char and @password[@second_index - 1] != @char) or
      (@password[@second_index - 1] == @char and @password[@first_index - 1] != @char)
  end
end

valid_passwords = 0
File.readlines('input.txt').each do |line|
  first_index, second_index, char, password = line.match(/([0-9]+)-([0-9]+) ([a-z]): (.*)/i).captures

  first_index = first_index.to_i
  second_index = second_index.to_i

  valid_passwords += 1 if Password.new(first_index, second_index, char, password).new_policy_valid?
end

puts valid_passwords

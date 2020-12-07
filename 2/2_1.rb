# frozen_string_literal: true

# Password defines a password and the policy it must conform to.
class Password
  def initialize(min_instances, max_instances, char, password)
    @min_instances = min_instances
    @max_instances = max_instances
    @char = char
    @password = password
  end

  def valid?
    @password.count(@char) >= @min_instances and @password.count(@char) <= @max_instances
  end
end

valid_passwords = 0
File.readlines('input.txt').each do |line|
  min_instances, max_instances, char, password = line.match(/([0-9]+)-([0-9]+) ([a-z]): (.*)/i).captures

  min_instances = min_instances.to_i
  max_instances = max_instances.to_i

  valid_passwords += 1 if Password.new(min_instances, max_instances, char, password).valid?
end

puts valid_passwords

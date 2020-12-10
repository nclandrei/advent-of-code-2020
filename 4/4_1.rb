# frozen_string_literal: true

# Passport defines a North Pole passport.
class Passport
  def initialize(lines)
    values = {}

    lines.each do |line|
      pairs = line.split(' ')
      pairs.each do |pair|
        parts = pair.split(':')
        values[parts[0]] = parts[1]
      end
    end

    @values = values
  end

  def valid?
    true if (@values.length == 8) || (@values.length == 7 && @values['cid'].nil?)
  end
end

passports = []
lines = File.readlines('input.txt')
i = 0
while i < lines.length
  passport_lines = []
  while lines[i] && lines[i].length > 1 && i < lines.length
    passport_lines.push(lines[i])
    i += 1
  end

  passports.push(Passport.new(passport_lines))
  i += 1
end

puts "#{passports.filter(&:valid?).length} valid passports"

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
    return false unless (@values.length == 8) || (@values.length == 7 && @values['cid'].nil?)

    year_valid?(@values['byr'], 1920, 2002) &&
      year_valid?(@values['iyr'], 2010, 2020) &&
      year_valid?(@values['eyr'], 2020, 2030) &&
      hgt_valid? &&
      hcl_valid? &&
      ecl_valid? &&
      pid_valid?
  end

  def year_valid?(value, from, to)
    false unless value.match(/^(\d){4}$/)
    year = value.to_i
    year >= from && year <= to
  end

  def hcl_valid?
    @values['hcl'].match(/^#([0-9]|[a-f]){6}$/)
  end

  def ecl_valid?
    valid_eye_colors = {
      'amb' => nil,
      'blu' => nil,
      'brn' => nil,
      'gry' => nil,
      'grn' => nil,
      'hzl' => nil,
      'oth' => nil
    }

    valid_eye_colors.key?(@values['ecl'])
  end

  def pid_valid?
    @values['pid'].match(/^0*[0-9]{9}$/)
  end

  def hgt_valid?
    false unless @values['hgt'].match(/^(\d){2,3}(cm|in)$/)

    number = @values['hgt'][0..-3].to_i
    measurement_type = @values['hgt'][-2..-1]

    (measurement_type == 'cm' && number >= 150 && number <= 193) ||
      (measurement_type == 'in' && number >= 59 && number <= 76)
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

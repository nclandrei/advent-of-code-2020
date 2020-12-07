# frozen_string_literal: true

SUM = 2020

values = {}
File.readlines('input.txt').each do |val|
  values[val.to_i] = nil
end

values.each do |val, _|
  puts val * (SUM - val) if values.key?(SUM - val)
end

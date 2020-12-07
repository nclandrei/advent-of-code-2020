# frozen_string_literal: true

SUM = 2020

values = {}
File.readlines('input.txt').each do |val|
  values[val.to_i] = nil
end

def product_of_numbers_that_sum(values, sum)
  values.each do |val, _|
    if values.key?(sum - val)
      return val * (sum - val)
    end
  end
  nil
end

values.each do |val, _|
  product = product_of_numbers_that_sum(values, SUM - val)
  puts val * product unless product.nil?
end


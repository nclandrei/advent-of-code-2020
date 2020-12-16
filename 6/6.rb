# frozen_string_literal: true

class Group
  def initialize(lines)
    @questions = {}
    @number_of_people = lines.length
    lines.each do |line|
      line.strip.chars.each do |char|
        @questions[char] = if @questions.key?(char)
                             @questions[char] + 1
                           else
                             1
                           end
      end
    end
  end

  def yes_questions
    @questions.length
  end

  def everyone_yes_questions
    count = 0

    @questions.each do |_question, number_of_people|
      count += 1 if number_of_people == @number_of_people
    end

    count
  end
end

groups = []
lines = File.readlines('input.txt')
i = 0
while i < lines.length
  group_lines = []
  while lines[i] && lines[i].length > 1 && i < lines.length
    group_lines.push(lines[i])
    i += 1
  end

  groups.push(Group.new(group_lines))
  i += 1
end

total_count = groups.reduce(0) { |sum, group| sum + group.yes_questions }
everyone_total_count = groups.reduce(0) { |sum, group| sum + group.everyone_yes_questions }
puts "Total count is: #{total_count}"
puts "Everyone total count is: #{everyone_total_count}"

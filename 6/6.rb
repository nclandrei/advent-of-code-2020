class Group
  def initialize(lines)
    @questions = {}
    lines.each do |line|
      line.strip.chars.each do |char|
        @questions[char] = nil unless @questions.key(char)
      end
    end
  end

  def yes_questions
    @questions.length
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
puts "Total count is: #{total_count}"



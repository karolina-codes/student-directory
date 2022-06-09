def input_students
  students = []

  puts 'Please enter the names of the students, to finish just hit return twice'
  name = gets.chomp.capitalize

  until name.empty? do
    students << { name: name, cohort: :November }
    puts "Now we have #{students.count} students"
    
    name = gets.chomp.capitalize
  end

  students
end

def print_header
  puts 'The students of Villains Academy'.center(75)
  puts '-------------'.center(75)
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1} #{student[:name]} (#{student[:cohort]} cohort)".center(75)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(75)
end

students = input_students

print_header
print(students)
print_footer(students)

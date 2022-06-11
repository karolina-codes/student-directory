@students = [] #empty array available to all methods

def input_students
  puts 'Please enter the names of the students, to finish just hit return twice'
  name = gets.chomp.capitalize

  until name.empty? do
    @students << { name: name, cohort: :November }
    puts "Now we have #{@students.count} students"
    
    name = gets.chomp.capitalize
  end
end

def print_header
  puts 'The students of Villains Academy'.center(100)
  puts '-------------'.center(100)
end

def print_students_list
  @students.each_with_index do |student, index|
    puts "#{index + 1} #{student[:name]} (#{student[:cohort]} cohort)".center(100)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(100)
end

def show_students
  print_header
  print_students_list
  print_footer
end


def print_menu
  puts "Choose an option (number):"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2' 
    if @students.empty? 
      puts 'Please input students first.'
    else
      show_students
    end
  when '3'
    save_students
  when '9'
    exit
  else
   puts "I don't know what you meant, try again"
  end
end


def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def save_students
  file = File.open('students.csv', 'w')

  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join("\n")
    file.puts csv_line
  end
  file.close
end

interactive_menu


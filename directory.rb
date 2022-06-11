# frozen_string_literal: true

@students = [] # empty array available to all methods

def create_students_arr(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

def input_students
  puts 'Please enter the names of the students, to finish just hit return twice'
  name = $stdin.gets.chomp.capitalize

  until name.empty?
    create_students_arr(name, 'November')
    puts "Now we have #{@students.count} students"

    name = $stdin.gets.chomp.capitalize
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
  puts "Choose an option (number):\n1. Input the students\n2. Show the students\n3. Save the list of students\n4. Load a list\n5. Clear the list in students.csv\n9. Exit" # rubocop:disable Layout/LineLength
end

def menu_process(selection) # rubocop:disable Metrics/MethodLength
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    puts 'Please enter a file name'
    save_students
  when '4'
    load_students
  when '5'
    clear_student_list
  when '9'
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    menu_process($stdin.gets.chomp)
  end
end

def save_students
  filename = gets.chomp
  File.open(filename, 'w') do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(',')
      file.puts csv_line
    end
  end
end

def load_students(filename = 'students.csv')
  File.open(filename, 'r') do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      create_students_arr(name, cohort)
    end
  end
  puts "Loaded #{@students.count} from #{filename}"
end

def try_load_students
  filename = ARGV.first # first argument from command line
  filename = 'students.csv' if filename.nil?
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def clear_student_list
  File.open('students.csv', 'w') { |file| file.truncate(0) }
end

try_load_students
interactive_menu

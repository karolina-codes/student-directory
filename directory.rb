@students = [] #empty array available to all methods

def input_students
  puts 'Please enter the names of the students, to finish just hit return twice'
  name = STDIN.gets.chomp.capitalize

  until name.empty? do
    @students << { name: name, cohort: :November }
    puts "Now we have #{@students.count} students"
    
    name = STDIN.gets.chomp.capitalize
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
  puts "4. Load the list from students.csv"
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
  when '4'
    load_students
  when '9'
    exit
  else
   puts "I don't know what you meant, try again"
  end
end


def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  file = File.open('students.csv', 'w')

  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, 'r')
  
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from command line
  return if filename.nil? #get out of the method if no argument given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end 
end

try_load_students
interactive_menu


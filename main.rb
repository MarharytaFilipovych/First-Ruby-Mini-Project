# frozen_string_literal: true

class Student
  @@all=[]
  attr_accessor :name, :date, :surname

  def initialize(name, surname, date)
    validate_date(date)
    @name = name
    @surname = surname
    @date = date
    add_student

  end
  def self.all
    @@all
  end

  def self.count_students
    @@all.size
  end

  def display
    puts "#{@name} #{@surname}, born on #{@date}"
  end

  def self.display_all_students_info
    if @@all.empty?
      puts "No students yet"
    else
      @@all.each { |student|  student.display }

    end
  end
  def unique?
    @@all.none?{|student| student.name == @name && student.surname == @surname && @date == self.date}
  end

  def add_student
    if unique?
      @@all << self
      puts "#{@name} #{@surname}, who was born on #{@date} was been added"
    else
      puts "#{@name} #{@surname}, who was born on #{@date} was added previously!"
    end
  end
  def get_given_date(date)
    day, month, year = date.split('-').map(&:to_i)
    Time.new(year, month, day)
  end

  def validate_date(date)
    given_date = get_given_date(date)
    raise ArgumentError, 'The date must be in the past!' if given_date > Time.now
  end


  def calculate_age
    given_date = get_given_date(@date)
    ((Time.now - given_date) / (60*60*24*365)).to_i
  end

  def self.remove_student(student)
    index = @@all.find_index { |s| s.name == student.name && s.surname == student.surname && s.date == student.date }
    if index
      @@all.delete_at(index)
      puts "#{student.name} #{student.surname}, who was born on #{student.date} was removed."
    else
      puts "Student is not here."
    end
  end

  def self.get_students_by_age(age)
    @@all.select{|student| student.calculate_age == age}
  end

  def self.get_student_by_name(name)
    @@all.select{|student| student.name == name}
  end
end


student1 = Student.new("Mary", "Fox", "03-04-2004")
student2 = Student.new("Kate", "Smith", "29-09-2017")
student4 = Student.new("Borys", "Lake", "01-01-2001")
student5 = Student.new("Mary", "Fox", "03-04-2004")
student6 = Student.new("Kate", "Smith", "29-09-2017")

puts "Student Info for Mary:"
student1.display

puts "Before deleting:"
Student.display_all_students_info

Student.remove_student(student1)

puts "After deleting:"
Student.display_all_students_info

puts "Searching for students named Kate:"
puts Student.get_student_by_name("Kate").map(&:display)

puts "Searching for students named '...':"
puts Student.get_student_by_name("...").map(&:display)

puts "Students aged 13:"
puts Student.get_students_by_age(13).map(&:display)

puts "Students aged 20:"
puts Student.get_students_by_age(20).map(&:display)

puts "Students aged #{student2.calculate_age}:"
puts Student.get_students_by_age(student2.calculate_age).map(&:display)
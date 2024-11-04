# frozen_string_literal: true

class Student
  @@all=[]
  attr_accessor :name, :date, :surname

  def initialize(name, surname, date)
    validate_date(date)
    @name = name
    @surname = surname
    @date = date

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
    !self.class.all.any? { |student| student.name == @name && student.surname == @surname && student.date == @date }
  end



  def self.add_student(student)
    if student.unique?
      @@all << student
    else
      puts "This student already exists."
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
    age = Time.now.year - given_date.year
    if (given_date.month > Time.now.month) || (given_date.day > Time.now.day && given_date.month == Time.now.month)then age -= 1 end
    age
  end

  def self.remove_student(student)
    index = @@all.find_index { |s| s.name == student.name && s.surname == student.surname && s.date == student.date }
    if index
      @@all.delete_at(index)
    end
  end

  def self.get_students_by_age(age)
    @@all.select{|student| student.calculate_age == age}
  end

  def self.get_student_by_name(name)
    @@all.select{|student| student.name == name}
  end
end

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
    @all.size
  end

  def display
    "#{@name} #{@surname}, born on #{@date_of_birth}"
  end

  def display_all_students_info
    @@all.each { |student| "#{student.name} #{student.surname}, born on #{student.date_of_birth}" }
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

  def remove_student(student)
    index = @@all.find_index { |s| s.name == student.name && s.surname == student.surname && s.date == student.date }
    if index
      @@all.delete_at(index)
      puts "#{student.name} #{student.surname}, who was born on #{student.date} was removed."
    else
      puts "Student is not here."
    end
  end

  def get_students_by_age(age)
    @@all.select{|student| student.calculate_age == age}
  end

  def get_student_by_name(name)
    @@all.select{|student| student.name == name}
  end
end
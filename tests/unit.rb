# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../main'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  reports_dir: 'C:/Users/marga/RubymineProjects/untitled/tests',
  report_filename: 'simple_test_results.html',
  add_timestamp: true
)



class MyTest < Minitest::Test

  def setup
    Student.all.clear
    @student = Student.new("Kira", "Smith", "12-12-2010")
    Student.add_student(@student)
  end

  def test_initialize
    assert_equal "Kira", @student.name
    assert_equal "Smith", @student.surname
    assert_equal "12-12-2010", @student.date
  end


  def test_add_student
    assert_includes Student.all, @student
  end

  def test_calculate_age
    age = @student.calculate_age
    assert_equal 13, age
  end

  def test_unique
    duplicate = Student.new("Kira", "Smith", "12-12-2010")
    refute duplicate.unique?, "Expected the duplicate student to not be unique"
  end

  def test_display
    assert_output("Kira Smith, born on 12-12-2010\n") {@student.display}
  end
  def test_get_by_age
    students = Student.get_students_by_age(@student.calculate_age)
    assert_includes students, @student
  end

  def test_get_student_by_name
    students = Student.get_student_by_name("Kira")
    assert_includes students, @student
  end

  def test_remove
    Student.remove_student(@student)
    refute_includes Student.all, @student
  end

  def teardown
    Student.all.clear
  end
end
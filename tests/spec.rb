# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require_relative '../main'


Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  reports_dir: 'C:/Users/marga/RubymineProjects/untitled/tests/spec_tests', # Create a separate folder for spec tests
  report_filename: 'spec_test_results.html', # Unique filename for spec test results
  add_timestamp: true
)



describe Student do
  before do
  Student.all.clear
  @student = Student.new("Sasha", "Fox", "13-10-2006")
  Student.add_student(@student)
  end

  describe "#initialize"do
    it "correctly initializes" do
      _(@student.name).must_equal "Sasha"
      _(@student.date).must_equal "13-10-2006"
      _(@student.surname).must_equal "Fox"
    end
  end


  describe "#add_student" do
    it "correctly adds students" do
      _(Student.all).must_include @student
    end
  end

  describe "#calculate_age" do
    it "correctly calculates age" do
      _(@student.calculate_age).must_equal 18
    end
  end

  describe "#unique?" do
    it "identifies duplicate students" do
    duplicate =  Student.new("Sasha", "Fox", "13-10-2006")
    _(duplicate.unique?).must_equal false
    end
  end

  describe "#display" do
    it "displays a student" do
      _{ @student.display }.must_output "Sasha Fox, born on 13-10-2006\n"
    end
  end


  describe "#get_by_age" do
    it "gets student by age" do
    _(Student.get_students_by_age(@student.calculate_age)).must_include @student
    end
  end

  describe "#get_by_name" do
    it "gets student by name" do
      _(Student.get_student_by_name(@student.name)).must_include @student
    end
  end

  describe "#remove" do
    it "removes student" do
      Student.remove_student(@student)
      _(Student.all).wont_include @student
    end
  end


  describe "#validate_date" do
    it "raises an ArgumentError for a future date" do
      _(@student.validate_date("12-12-2026")).must_raise ArgumentError
    end
  end


  after do
    Student.all.clear
  end
end
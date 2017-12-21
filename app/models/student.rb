class Student < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :courses, through: :grades, dependent: :destroy

  attr_reader :student

  def intialize(name)
    @student = (Student.find_by_name name)
  end

  def course_list
    @student.courses.map do |course|
      course.course_title
    end
  end

  def grade_percentages
    @student.grades.map do |grade|
      grade.percentage
    end
  end
end

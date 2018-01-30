class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  belongs_to :teacher

  # delegate :name, to: :teacher, prefix: :teacher

  def teachers_name
    teacher&.name
  end

  def course_average
    all_grades_in_course = self.enrollments.map do |g|
      g.grade
    end
    sum = all_grades_in_course.sum do |g|
      g.nil? ? 0 : g
    end
    sum/(all_grades_in_course.size unless all_grades_in_course.size.zero?)
  end
end

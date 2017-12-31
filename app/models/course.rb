class Course < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :students, through: :grades

  def teachers_name
    Teacher.find_by_id(self.teacher_id)&.name
  end

  def course_average
    percentage_grds = self.grades.map do |g|
      g.percentage
    end
    sum = percentage_grds.sum do |g|
      g.nil? ? 0 : g
    end
    sum/(percentage_grds.size unless percentage_grds.size.zero?)
  end
end

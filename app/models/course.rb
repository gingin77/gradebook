class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  belongs_to :teacher

  def teachers_name
    Teacher.find_by_id(self.teacher_id)&.name
  end

  def course_average
    percentage_grds = self.enrollments.map do |g|
      g.percentage
    end
    sum = percentage_grds.sum do |g|
      g.nil? ? 0 : g
    end
    sum/(percentage_grds.size unless percentage_grds.size.zero?)
  end
end

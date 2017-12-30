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
    percentage_grds&.inject do
      |acc, g| acc ? acc + g : g end.to_f.round(2)/(percentage_grds.size unless percentage_grds.size.zero?)
  end
end

class Course < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :students, through: :grades

  def teachers_name
    Teacher.find_by_id(self.teacher_id).name
  end

  def course_average
    percentage_grds = self.grades.map {|g| g.percentage }
    percentage_grds.inject {|acc, g| acc + g}.to_f.round(2)/(percentage_grds.size)
  end
end

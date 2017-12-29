class Teacher < ApplicationRecord
  has_one :user, as: :identifiable
  has_many :courses
  has_many :grades, through: :courses
  has_many :students, through: :grades

  # def teachers_grades?
  #   Grade.all.select do |g|
  #     teacher = Teacher.find(user.identifiable_id)
  #     teachers_courses = teacher.courses.map {|c| c.id }
  #     teachers_courses.include?(g.course_id)
  #   end
  # end
end

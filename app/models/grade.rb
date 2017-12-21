class Grade < ApplicationRecord
  belongs_to :course
  belongs_to :student

  validates_uniqueness_of :course_id, scope: [:student_id]
end

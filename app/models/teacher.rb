class Teacher < ApplicationRecord
  has_one :user, as: :identifiable
  has_many :courses
  has_many :enrollments, through: :courses
end

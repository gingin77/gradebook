class Teacher < ApplicationRecord
  has_one :user, as: :identifiable
  has_many :courses
  has_many :grades, through: :courses
end

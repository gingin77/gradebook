class Student < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :courses, through: :grades
  validates :courses, length: {maximum: 4}
end

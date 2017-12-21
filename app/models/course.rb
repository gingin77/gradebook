class Course < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :students, through: :grades, dependent: :destroy
end

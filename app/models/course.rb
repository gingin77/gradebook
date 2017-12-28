class Course < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :students, through: :grades
  # belongs_to :teacher < was not able to rake seed file when "belongs_to :teacher" is uncommented
end

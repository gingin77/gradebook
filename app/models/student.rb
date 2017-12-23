class Student < ApplicationRecord
  has_many :grades, dependent: :destroy
  has_many :courses, through: :grades, dependent: :destroy

  # validates :name, presence: true
end

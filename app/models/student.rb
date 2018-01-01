class Student < ApplicationRecord
  has_one :user, as: :identifiable
  has_many :grades, dependent: :destroy
  has_many :courses, through: :grades

  validates :courses, length: {maximum: 4}

  def gpa
    gpa = GPAFinder.new(self.id)
    gpa = gpa.gp_average
  end
end

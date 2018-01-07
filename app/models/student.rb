class Student < ApplicationRecord
  has_one :user, as: :identifiable
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  validates :courses, length: {maximum: 4}

  def gpa
    gpa = GPAFinder.new(self.id)
    gpa.gp_average
  end
end

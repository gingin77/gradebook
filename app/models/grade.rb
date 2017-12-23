class Grade < ApplicationRecord
  belongs_to :course
  belongs_to :student

  # validates_uniqueness_of :course_id, scope: :student_id
  #
  # validates_presence_of :percentage
  # before_validation :set_percentage

  def get_course_title
    Course.find_by_id(self.course_id).course_title
  end

  def get_student_name
    Student.find_by_id(self.student_id).name
  end

  # def all_grds_for_std
  #   Grade.where(student_id: self.student_id).map { |g| g.percentage }
  # end


  # private
  #
  #   def set_percentage
  #     unless percentage.present?
  #       self.percentage = "No grade"
  #     end
  #   end

end

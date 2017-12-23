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

  def percnt_to_ltr
    GradeConverter.percnt_to_ltr(self.percentage)
  end

  def ltr_to_grd_pts
    GradeConverter.ltr_to_grd_pts(self.percnt_to_ltr)
  end



  # private
  #
  #   def set_percentage
  #     unless percentage.present?
  #       self.percentage = "No grade"
  #     end
  #   end

end

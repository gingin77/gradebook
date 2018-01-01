require "grade_consts.rb"

class Grade < ApplicationRecord
  include GradeConsts

  belongs_to :course
  belongs_to :student

  validates_numericality_of :percentage, less_than: 101, :allow_blank => true
  validates_uniqueness_of :course_id, scope: :student_id

  validate :limit_a_student_to_4_courses, on: :create
  validate :cap_course_enrollment_at_16, on: :create

  def limit_a_student_to_4_courses
    students_grds = Grade.where(student_id: self.student_id)
    if students_grds.length == 4
      errors.add(:student_id, "New grade records cannot be created for a student already enrolled in 4 courses")
    end
  end

  def cap_course_enrollment_at_16
    grd_records_studs_in_a_course = Grade.where(course_id: self.course_id)
    if grd_records_studs_in_a_course.length == 16
      errors.add(:course_id, "Course enrollment is limited to 16 students per term")
    end
  end

  def get_course_title
    Course.find_by_id(self.course_id).course_title
  end

  def get_student_name
    Student.find_by_id(self.student_id).name
  end

  def percnt_to_ltr
    GradeConsts::PRCT_TO_LTR.select {|k, v| break v if k.cover? self.percentage }
  end

  def ltr_to_grd_pts
    GradeConsts::LTR_TO_GRD_PTS.select {|k, _| k == percnt_to_ltr}.values.join('')
  end
end

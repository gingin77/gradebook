require "grade_consts.rb"

class Enrollment < ApplicationRecord
  include GradeConsts

  belongs_to :course
  belongs_to :student

  delegate :course_title, to: :course, prefix: :course
  delegate :name, to: :student, prefix: :student

  validates_numericality_of :grade, less_than: 101, :allow_blank => true
  validates_uniqueness_of :course_id, scope: :student_id

  validate :limit_a_student_to_4_courses, on: :create
  validate :cap_course_enrollment_at_16, on: :create

  def percnt_to_ltr
    GradeConsts::PRCT_TO_LTR.select {|k, v| break v if k.cover? self.grade }
  end

  def ltr_to_grd_pts
    GradeConsts::LTR_TO_GRD_PTS.select {|k, _| k == percnt_to_ltr}.values.join('')
  end

  private

  def limit_a_student_to_4_courses
    students_enrollments = Enrollment.where(student_id: self.student_id)
    if students_enrollments.length == 4
      errors.add(:student_id, "Students cannot be enrolled in more than 4 courses")
    end
  end

  def cap_course_enrollment_at_16
    num_studs_in_a_course = Enrollment.where(course_id: self.course_id)
    if num_studs_in_a_course.length == 16
      errors.add(:course_id, "Course enrollment is limited to 16 students per term")
    end
  end
end

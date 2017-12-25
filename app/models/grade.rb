class Grade < ApplicationRecord
  belongs_to :course
  belongs_to :student

  validates_numericality_of :percentage, less_than: 103, :allow_blank => true
  validates_uniqueness_of :course_id, scope: :student_id
  validate :limit_a_student_to_4_courses
  validate :place_cap_on_course_enrollment_to_32

  def limit_a_student_to_4_courses
    students_grds = Grade.where(student_id: self.student_id)
    if students_grds.length == 4
      errors.add(:base, "New grade records cannot be created for a student already enrolled in 4 courses this term")
    end
  end

  def place_cap_on_course_enrollment_to_32
    grd_records_studs_in_a_course = Grade.where(course_id: self.course_id)
    if grd_records_studs_in_a_course.length == 32
      errors.add(:base, "Course enrollment is limited to 32 students per term")
    end
  end

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
end

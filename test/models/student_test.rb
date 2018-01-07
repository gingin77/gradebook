require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @stud_w_4_courses = students(:one)
    @stud_w_3_courses = students(:three)
    @stud_to_delete = students(:four)
  end

  test 'student has 4 courses' do
    assert_equal 4, @stud_w_4_courses.courses.length
  end

  test 'student with 4 courses is valid' do
    assert @stud_w_4_courses.valid?
  end

  test 'student cannot have more than 4 courses' do
    stud_w_7_courses = students(:two)
    assert !stud_w_7_courses.valid?
  end

  test 'up to 4 courses can be added for a student' do
    @stud_w_3_courses.courses << courses(:physics)
    assert @stud_w_3_courses.save
  end

  test 'a student can be deleted' do
    @stud_to_delete.destroy
    assert @stud_to_delete.destroyed?
  end

  test 'when the student is deleted, all enrollments for the student are deleted' do
    enrollments_to_delete = @stud_to_delete.enrollments
    @stud_to_delete.destroy
    assert_empty enrollments_to_delete
  end

  test 'when a student drops a course, only the enrollment record is dropped' do
    enrollment_to_drop = enrollments(:one)
    student, course = enrollment_to_drop.student, enrollment_to_drop.course
    enrollment_to_drop.destroy

    assert enrollment_to_drop.destroyed?
    assert_not course.destroyed?
    assert_not student.destroyed?
  end

  test 'student id can be used to located the associated user id' do
    stud_id = @stud_w_4_courses.id
    associated_user = User.find_by_identifiable_id(stud_id)
    assert_not_nil User, associated_user
  end

  test 'student has a gpa' do
    gpa = @stud_w_4_courses.gpa
  end

  def teardown
    Rails.cache.clear
  end
end

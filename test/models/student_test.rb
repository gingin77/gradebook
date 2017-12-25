require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @stud_w_4_courses_not_incld_physics = students(:one)
    @stud_w_7_courses = students(:two)
    @stud_w_3_courses = students(:three)
    @stud_to_delete = students(:four)
    @course_physics = courses(:physics)
    @stud_new = students(:fix_6)
  end

  test 'student has 4 courses' do
    assert_equal 4, @stud_w_4_courses_not_incld_physics.courses.length
  end

  test 'student with 4 courses is valid' do
    assert @stud_w_4_courses_not_incld_physics.valid?
  end

  test 'student cannot have more than 4 courses' do
    assert !@stud_w_7_courses.valid?
  end

  test 'up to 4 courses can be added for a student' do
    @stud_w_3_courses.courses << @course_physics
    assert @stud_w_3_courses.save
  end

  test 'a student can be deleted' do
    @stud_to_delete.destroy
    assert @stud_to_delete.destroyed?
  end

  test 'when the student is deleted, all grades for the student are deleted' do
    grades_to_delete = @stud_to_delete.grades
    @stud_to_delete.destroy
    assert_empty grades_to_delete
  end

  test 'when a student drops a course, the student and course remain in db, but the grade record is dropped' do
    grade_to_drop = grades(:one)
    student, course = grade_to_drop.student, grade_to_drop.course
    grade_to_drop.destroy
    assert grade_to_drop.destroyed?
    assert_not course.destroyed?
    assert_not student.destroyed?
  end

  def teardown
    Rails.cache.clear
  end
end

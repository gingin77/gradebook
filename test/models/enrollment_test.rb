require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  setup do
    @enrollment_w_percentage = enrollments(:one)

    @stud_w_4_courses = students(:one)
    @stud_w_3_courses = students(:three)

    @physics = courses(:physics)
  end

# Tests related to enrollment percentage value
  test 'enrollment record has a enrollment percentage value' do
    assert !@enrollment_w_percentage.percentage.nil?
  end

  test 'enrollment percentage can be blank' do
    enrollment_w_no_percentage = enrollments(:thirteen)
    assert enrollment_w_no_percentage.percentage.nil?
  end

  test 'enrollment percentage is a finite number' do
    assert @enrollment_w_percentage.percentage.finite?
  end

  test 'enrollment percentage falls within expected range' do
    assert (0..101).include? (@enrollment_w_percentage.percentage)
  end

# Tests related to converting percentage score
  test 'enrollment percentages convert to letter enrollments' do
    assert_equal "A", @enrollment_w_percentage.percnt_to_ltr
  end

  test 'enrollment percentages convert to points for gpa' do
    assert_equal "4.0", @enrollment_w_percentage.ltr_to_grd_pts
  end

# Tests related to validations on the enrollment record
  test 'should not save enrollment record without student or course' do
    enrollment = Enrollment.new
    assert_not enrollment.save
  end

  test 'should save enrollment record with student and course' do
    enrollment = Enrollment.new
    enrollment.course, enrollment.student = @physics, @stud_w_3_courses
    assert enrollment.save
  end

  test 'should not save enrollment record when percentage is too high' do
    enrollment = Enrollment.new
    enrollment.course, enrollment.student, enrollment.percentage = @physics, @stud_w_3_courses, 200
    assert_not enrollment.save
  end

  test 'student cannot be enrolled in same class twice' do
    # @stud_w_3_courses has a enrollment record associated with the quidditch course
    quidditch = courses(:quidditch)
    enrollment = Enrollment.new
    enrollment.course, enrollment.student = quidditch, @stud_w_3_courses
    assert_not enrollment.save
  end

# Tests related to custom validation methods in enrollment.rb
  test 'student can not have greades for more than 4 classes' do
    enrollment = Enrollment.new
    enrollment.student, enrollment.course = @stud_w_4_courses, @physics
    assert_not enrollment.save
  end

  test 'course size is limited to 16 students' do
    course_w_16_students = courses(:organic_chemisty)
    enrollment = Enrollment.new
    enrollment.student = students(:student_fix_14)
    enrollment.course = course_w_16_students
    assert_not enrollment.save
  end

  def teardown
    Rails.cache.clear
  end
end

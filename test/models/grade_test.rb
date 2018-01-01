require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  setup do
    @grade_w_percentage = grades(:one)

    @stud_w_4_courses = students(:one)
    @stud_w_3_courses = students(:three)

    @physics = courses(:physics)
  end

# Tests related to grade percentage value
  test 'grade record has a grade percentage value' do
    assert !@grade_w_percentage.percentage.nil?
  end

  test 'grade percentage can be blank' do
    grade_w_no_percentage = grades(:thirteen)
    assert grade_w_no_percentage.percentage.nil?
  end

  test 'grade percentage is a finite number' do
    assert @grade_w_percentage.percentage.finite?
  end

  test 'grade percentage falls within expected range' do
    assert (0..101).include? (@grade_w_percentage.percentage)
  end

# Tests related to converting percentage score
  test 'grade percentages convert to letter grades' do
    assert_equal "A", @grade_w_percentage.percnt_to_ltr
  end

  test 'grade percentages convert to points for gpa' do
    assert_equal "4.0", @grade_w_percentage.ltr_to_grd_pts
  end

# Tests related to validations on the grade record
  test 'should not save grade record without student or course' do
    grade = Grade.new
    assert_not grade.save
  end

  test 'should save grade record with student and course' do
    grade = Grade.new
    grade.course, grade.student = @physics, @stud_w_3_courses
    assert grade.save
  end

  test 'should not save grade record when percentage is too high' do
    grade = Grade.new
    grade.course, grade.student, grade.percentage = @physics, @stud_w_3_courses, 200
    assert_not grade.save
  end

  test 'student cannot be enrolled in same class twice' do
    # @stud_w_3_courses has a grade record associated with the quidditch course
    quidditch = courses(:quidditch)
    grade = Grade.new
    grade.course, grade.student = quidditch, @stud_w_3_courses
    assert_not grade.save
  end

# Tests related to custom validation methods in grade.rb
  test 'student can not have greades for more than 4 classes' do
    grade = Grade.new
    grade.student, grade.course = @stud_w_4_courses, @physics
    assert_not grade.save
  end

  test 'course size is limited to 16 students' do
    course_w_16_students = courses(:organic_chemisty)
    grade = Grade.new
    grade.student = students(:student_fix_14)
    grade.course = course_w_16_students
    assert_not grade.save
  end

  def teardown
    Rails.cache.clear
  end
end

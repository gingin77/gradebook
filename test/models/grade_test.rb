require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  setup do
    @grade_valid_w_perct = grades(:one)
    @grade_valid_without_perct = grades(:thirteen)
    @stud_w_4_courses = students(:one)
    @stud_w_3_courses_incld_quidditch = students(:three)
    @course_quidditch = courses(:quidditch)
    @course_physics = courses(:physics)
    @course_w_32_students = courses(:organic_chemisty)
  end

  test 'grade percentage can be left blank' do
    assert @grade_valid_without_perct.percentage.nil?
  end

  test 'grade record has a grade percentage value' do
    refute @grade_valid_w_perct.percentage.nil?
  end

  test 'grade percentage is a finite number' do
    assert @grade_valid_w_perct.percentage.finite?
  end

  test 'grade percentage falls within expected range' do
    assert (0..105).include? (@grade_valid_w_perct.percentage)
  end

  test 'should not save grade record without student or course' do
    grade = Grade.new
    assert_not grade.save
  end

  test 'should save grade record with student and course' do
    grade = Grade.new
    grade.student, grade.course, grade.percentage = @stud_w_3_courses_incld_quidditch, @course_physics, ''
    assert grade.save
  end

  test 'should not save grade record when percentage is too high' do
    grade = Grade.new
    grade.student, grade.course, grade.percentage = @stud_w_3_courses_incld_quidditch, @course_physics, 200
    assert_not grade.save
  end

  test 'student cannot be enrolled in same class twice during a term' do
    grade = Grade.new
    grade.student, grade.course, grade.percentage = @stud_w_3_courses_incld_quidditch, @course_quidditch
    assert_not grade.save
  end

  test 'should not save new grade record for student who already has 4 classes' do
    grade = Grade.new
    grade.student, grade.course = @stud_w_4_courses, @course_physics
    assert_not grade.save
  end

  test 'course size is limited to 32 students' do
    grade = Grade.new
    grade.student = students(:fix_49)
    grade.course = @course_w_32_students
    assert_not grade.save
  end

  def teardown
    Rails.cache.clear
  end
end

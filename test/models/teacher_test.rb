require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  setup do
    @teacher = teachers(:one)
    @teacher2 = teachers(:two)
    @organic_chemisty = courses(:organic_chemisty)
    @teacher_of_org_chem = @teacher2
    @art_history_two = courses(:art_history_two)
    @calculus = courses(:calculus)
    @teacher_for_2_courses = @teacher
  end

  test 'teaecher has a name (proper)' do
    assert_not_nil @teacher.name
  end

  test 'teacher has a username and password' do
    assert_not_nil @teacher.user.username
    assert_not_nil @teacher.user.password_digest
  end

  test 'teacher has 2 courses' do
    assert_equal 2, @teacher.courses.count
  end

  test 'teacher has grades' do
    assert_not_nil @teacher.grades
  end

  test 'teacher with 1 course has students' do
    x = @organic_chemisty.students.count
    assert_equal x, @teacher_of_org_chem.students.count
  end

  test 'teacher has enrollment counts for different classes' do
    skip
    all_students_for_teacher = @teacher.students.count
    puts all_students_for_teacher
    puts @calculus.students.count
    puts @art_history_two.students.count
  end

end

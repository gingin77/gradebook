require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  setup do
    @teach_2_courses = teachers(:one)
  end

  test 'teaecher has a name (proper)' do
    assert_not_nil @teach_2_courses.name
  end

  test 'teacher has a username and password' do
    assert_not_nil @teach_2_courses.user.username
    assert_not_nil @teach_2_courses.user.password_digest
  end

  test 'teacher has 2 courses' do
    assert_equal 2, @teach_2_courses.courses.count
  end

  test 'teacher has grades' do
    assert_not_nil @teach_2_courses.grades
  end

  test 'teacher with 1 course has students' do
    teacher_of_org_chem = teachers(:two)
    organic_chemisty = courses(:organic_chemisty)
    x = organic_chemisty.students.count
    assert_equal x, teacher_of_org_chem.students.count
  end

  test 'teacher has enrollment counts for different classes' do
    first_c_count = @teach_2_courses.courses[0].students.count
    sec_c_count = @teach_2_courses.courses[1].students.count
    c_count_1 = courses(:art_history_two).students.count
    c_count_2 = courses(:calculus).students.count
    assert_equal c_count_1, first_c_count
    assert_equal c_count_2, sec_c_count
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user5 = users(:five)
    @student_user = @user1
    @teacher_user = users(:teacher)
  end

  test 'is student?' do
    assert @user1.student?
    refute @teacher_user.student?
  end

  test 'is teacher?' do
    assert @teacher_user.teacher?
    refute @user1.teacher?
  end

  test 'grade belongs to teacher?' do
    grade_for_org_chem = grades(:one)
    teacher_for_org_chem = users(:four)
    assert teacher_for_org_chem.has_grade?(grade_for_org_chem)
  end

  test 'user is valid' do
    assert @user1.valid?
  end

  test 'user is identifiable' do
    assert_not @user1.identifiable.blank?
  end

  test 'user is not identifiable' do
    assert @user2.identifiable.blank?
  end

  test 'user is not valid without identifiable' do
    assert_not @user2.valid?
  end

  test 'identifiable user belongs to a student' do
    assert_equal "Student", @student_user.identifiable_type
  end

  test 'usernames are unique' do
    name1 = @user1.username
    name2 = @user2.username
    assert name1 != name2
  end

  test 'usernames are required to be unique' do
    name2 = @user2.username
    @user1.username = name2
    @user1.save
    assert_not @user1.valid?
  end

  test 'user must have a password' do
    @user1.password_digest = nil
    @user1.save
    assert_not @user1.valid?
  end

  test 'user can be a teacher' do
    assert_equal "Teacher", @teacher_user.identifiable_type
  end

  test 'teacher user has a password' do
    assert_not_nil @teacher_user.password_digest
  end

  test 'user can access students name' do
    skip
    name = ??
    assert_equal name, @user1.get_proper_name
  end

  test 'get user type' do
    assert_equal "Teacher", @teacher_user.identifiable_type
  end
end

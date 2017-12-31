require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user_stud_type = users(:one)
    @user_no_id_type = users(:one_non_identifiable)
    @user_teacher_type = users(:teach_user_auth)
  end

  # Tests related to user validations
  test 'user is valid' do
    assert @user_stud_type.valid?
  end

  test 'user is identifiable' do
    assert_not @user_stud_type.identifiable.blank?
  end

  test 'user is not identifiable' do
    assert @user_no_id_type.identifiable.blank?
  end

  test 'user is not valid without identifiable' do
    assert_not @user_no_id_type.valid?
  end

  test 'identifiable type method return a string' do
    assert_equal "Student", @user_stud_type.identifiable_type
  end

  test 'usernames in db are unique' do
    name1 = @user_stud_type.username
    name2 = @user_no_id_type.username
    assert name1 != name2
  end

  test 'usernames are required to be unique' do
    name2 = @user_no_id_type.username
    @user_stud_type.username = name2
    @user_stud_type.save
    assert_not @user_stud_type.valid?
  end

  test 'user must have a password' do
    @user_stud_type.password_digest = nil
    @user_stud_type.save
    assert_not @user_stud_type.valid?
  end

  test 'user can be a teacher' do
    assert_equal "Teacher", @user_teacher_type.identifiable_type
  end

  test 'get user type' do
    assert_equal "Teacher", @user_teacher_type.identifiable_type
  end

  # Tests for custom methods added to the User model
  test 'user can access name property on affiliated class instance' do
    name = teachers(:one).name
    user = users(:teach_user_auth)
    assert_equal name, user.get_proper_name
  end

  test 'is student?' do
    assert @user_stud_type.student?
    refute @user_teacher_type.student?
  end

  test 'is teacher?' do
    assert @user_teacher_type.teacher?
    refute @user_stud_type.teacher?
  end

  test 'is admin?' do
    admin = users(:admin_user)
    assert admin.admin?
    refute @user_teacher_type.admin?
  end
end

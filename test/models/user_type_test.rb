require 'test_helper'

class UserTypeTest < ActiveSupport::TestCase
  setup do
    @user_st = users(:unauthorized_user_st)
    @teacher_user = users(:teach_user_auth)
  end

  test 'the user class is recognized' do
    assert_kind_of User, @user_st
    assert_kind_of User, @teacher_user
  end

  test 'a user type can be verified' do
    assert_equal "Student", @user_st.identifiable_type
    assert_equal "Teacher", @teacher_user.identifiable_type
  end

  test 'a new UserType obj can be made with a User obj' do
    usertype = UserType.new(@user_st)
    assert_not_nil usertype
  end

  test 'a users fullname is available, when student' do
    id1 = @user_st.identifiable_id
    name = Student.find(id1).name
    new_user_type = UserType.new(@user_st)
    assert_equal name, new_user_type.get_name
  end

  test 'a users fullname is available, when teacher' do
    id1 = @teacher_user.identifiable_id
    name = Teacher.find(id1).name
    new_user_type = UserType.new(@teacher_user)
    assert_equal name, new_user_type.get_name
  end
end

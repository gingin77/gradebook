require 'test_helper'

class UserTypeTest < ActiveSupport::TestCase
  setup do
    @student_user = users(:one)
    @teacher_user = users(:three)
    @usertype = UserType.new(@student_user)
    @usertype2 = UserType.new(@teacher_user)
  end

  test 'the user class is recognized' do
    assert_kind_of User, @student_user
    assert_kind_of User, @teacher_user
  end

  test 'a user type can be verified' do
    assert_equal "Student", @student_user.identifiable_type
    assert_equal "Teacher", @teacher_user.identifiable_type
  end

  test 'a user has an identifiable_id' do
    assert_equal 1, @usertype.id_ut
  end

  test 'a users fullname is available' do
    assert_equal "Harry Potter", @usertype.get_name
    assert_equal "Minerva McGonagall", @usertype2.get_name
  end
end

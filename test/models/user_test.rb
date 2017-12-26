require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
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
    assert_equal "Student", @user1.identifiable_type
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

  test 'user has a password' do
    @user1.password_digest = nil
    @user1.save
    assert_not @user1.valid?
  end
end

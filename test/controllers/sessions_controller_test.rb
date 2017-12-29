require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_auth = users(:six)
    @teacher_user = users(:three)
  end

  test 'logout path is generated and recognized' do
    assert_routing({method: 'delete', path: 'logout'}, {controller: "sessions", action: "destroy"})
  end

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      username: @user_auth.username,
      password: "password"
      }
    assert is_logged_in?
    assert_redirected_to home_path
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select 'p', "Welcome, #{@user_auth.get_proper_name} | Logout"
  end


  test "unique student view is displayed on login" do
    a_student = @user_auth
    ability = Ability.new(a_student)
    assert ability.can?(:read, Student)
    assert_not ability.can?(:read, Grade)
    log_in_as(a_student)
    assert is_logged_in?
    assert_redirected_to home_path
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", student_path(@user_auth.identifiable_id)
  end

  test "unique teacher view is displayed on login" do
    skip
    a_teacher = @teacher_user
    ability = Ability.new(a_teacher)
    # assert_not ability.can?(:read, Student)
    assert ability.can?(:read, Grade)
    # log_in_as(a_teacher)
    # assert is_logged_in?
    # assert_redirected_to home_path
    # follow_redirect!
    # assert_template 'users/show'
    # assert_select "a[href=?]", student_path(@user_auth.identifiable_id)
  end


  test "login attempt invalid" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      username: " ",
      password: " " }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get login_path
    assert flash.empty?
  end

  test "login as student" do
    get login_path
    assert_template 'sessions/new'
    log_in_as(@user_auth)
    assert is_logged_in?
    assert_equal "Student", @user_auth.identifiable_type
  end

  test "login as teacher" do
    get login_path
    assert_template 'sessions/new'
    log_in_as(@teacher_user)
    assert is_logged_in?
    assert_equal "Teacher", @teacher_user.identifiable_type
  end

  def teardown
    Rails.cache.clear
  end
end

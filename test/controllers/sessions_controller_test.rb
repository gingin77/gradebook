require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @st_user_auth = users(:authorized_user_st)
    @teach_u_auth = users(:teach_user_auth)
    @admin_u_auth = users(:admin_user)
  end

  test "login with valid information allows access" do
    get login_path
    post login_path, params: {
      username: @admin_u_auth.username,
      password: "password"
      }
    assert is_logged_in?
    assert_redirected_to courses_path
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select 'p', "Welcome, #{@admin_u_auth.get_proper_name} | Logout"
  end

  test "invalid login attempt results in redirect and message" do
    get login_path
    post login_path, params: {
      username: " ",
      password: " " }
    assert_not is_logged_in?
    assert_not flash.empty?
    get login_path
    assert flash.empty?
  end

  test '"auth admin sees enrollment counts and grades upon login' do
    log_in_as(@admin_u_auth)
    assert is_logged_in?
    assert_redirected_to courses_path
    follow_redirect!
    assert_select "a[href=?]", students_path
    assert_select 'th', "Enrollment Count"
    assert_select 'th', "Average Grade"
  end

  test "auth admin has apropriate access permissions" do
    ability = Ability.new(@admin_u_auth)
    assert ability.can?(:show, Student)
    assert ability.can?(:index, Student)
    assert_not ability.can?(:manage, Course)
    assert_not ability.can?(:show, Teacher)
    assert_not ability.can?(:edit, Grade)
  end


  test "auth student lands on personal page at login" do
    log_in_as(@st_user_auth)
    assert is_logged_in?
    assert_redirected_to student_path(@st_user_auth.identifiable_id)
    follow_redirect!
    assert_select 'p', "Welcome, #{@st_user_auth.get_proper_name} | Logout"
    assert_select 'th', "Course"
    assert_select "a[href=?]", courses_path
  end

  test "auth student has apropriate access permissions" do
    ability = Ability.new(@st_user_auth)
    assert ability.can?(:show, Student)
    assert ability.can?(:index, Course)
    assert_not ability.can?(:show, Teacher)
    assert_not ability.can?(:index, Student)
    assert_not ability.can?(:manage, Grade)
  end

  test "auth teacher lands on correct page after login" do
    teachers_course = courses(:art_history_two)
    log_in_as(@teach_u_auth)
    assert is_logged_in?
    assert_redirected_to teacher_path(@teach_u_auth.identifiable_id)
    follow_redirect!
    assert_select 'p', "Welcome, #{@teach_u_auth.get_proper_name} | Logout"
    assert_select "a[href=?]", course_path(teachers_course.id)
  end

  test "auth teacher has apropriate access permissions" do
    ability = Ability.new(@teach_u_auth)
    assert ability.can?(:show, Teacher)
    assert_not ability.can?(:show, Student)
    assert_not ability.can?(:index, Student)
    assert ability.can?(:edit, Grade)
    assert ability.can?(:manage, Course)
  end

  test 'auth teacher can visit own course pages but gets redirected if tries to access other teachers courses' do
    log_in_as(@teach_u_auth)
    get teacher_path(@teach_u_auth.identifiable_id)
  end

  test "login as student works" do
    get login_path
    log_in_as(@st_user_auth)
    assert is_logged_in?
    assert_equal "Student", @st_user_auth.identifiable_type
  end

  test "login as teacher works" do
    get login_path
    log_in_as(@teach_u_auth)
    assert is_logged_in?
    assert_equal "Teacher", @teach_u_auth.identifiable_type
  end

  test 'logout path is generated and recognized' do
    assert_routing({method: 'delete', path: 'logout'}, {controller: "sessions", action: "destroy"})
  end

  def teardown
    Rails.cache.clear
  end
end

require 'test_helper'

class GradesControllerTest < ActionDispatch::IntegrationTest
  # def setup
  #   @physics = courses(:physics)
  #   @stud_w_3_cs = students(:three)
  # end
  #
  # test 'when teacher adds eligible student to course, a new grade is stored' do
  #   get new_course_grade_path(@physics.id)
  #   assert_response :success
  #   post new_course_grade, params: {
  #     students_name: "Ron Weasley"
  #   }
  #
  # end
  #
  # test 'downcase input from user can be used to query db' do
  # end
  #
  # test "login with valid information allows access" do
  #   get login_path
  #   post login_path, params: {
  #     username: @admin_u_auth.username,
  #     password: "password"
  #     }
  #   assert is_logged_in?
  #   assert_redirected_to courses_path
  #   follow_redirect!
  #   assert_select "a[href=?]", login_path, count: 0
  #   assert_select "a[href=?]", logout_path
  #   assert_select 'p', "Welcome, #{@admin_u_auth.get_proper_name} | Logout"
  # end
end

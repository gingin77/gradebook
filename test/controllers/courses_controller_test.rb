require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "redirect if user is NOT logged in" do
    get courses_path
    assert_equal 302, status
    assert_redirected_to login_path
  end

  # test "allow access to courses index page once logged in" do
  #   get courses_path
  #   assert_equal 200, status
  #   assert_response :success
  #   assert_redirected_to login_path
  # end
  #
  # test "should get course show" do
  #   course = courses(:physics)
  #   get course_url(course)
  #   assert_response :success
  # end

end

require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "redirect if user is NOT logged in" do
    get courses_path
    assert_equal 302, status
    assert_redirected_to login_path
  end
end

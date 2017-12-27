require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get course index" do
    skip
    get courses_url
    assert_response :success
  end

  test "should get course show" do
    skip
    course = courses(:physics)
    get course_url(course)
    assert_response :success
  end

end

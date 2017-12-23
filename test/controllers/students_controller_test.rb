require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # skip
    get students_url
    assert_response :success
  end

  test "should show student" do
    student = students(:one)
    get student_url(student)
    assert_response :success
  end

end

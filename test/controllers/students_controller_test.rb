require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @stud_no_creds = students(:stud_u_no_creds)
    # @stud_plus_creds = students(:stud_u_creds)
    @user_auth = users(:six)
  end

  test "should get index" do
    skip
    get students_url
    assert_response :success
  end

  test "should redirect unauthorized student to login" do
    skip
    get student_path(@user_auth.id)
    assert_redirected_to login_url
  end

  test "should allow authorized student to access show route" do
    skip
    get student_path(@user_auth.id)
    assert_response :success
  end
end

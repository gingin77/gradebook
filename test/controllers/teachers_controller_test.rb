require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = users(:teach_user_auth)
    @student = users(:authorized_user_st)
  end

  test "should get show" do
    log_in_as(@teacher)
    get teacher_path(@teacher.id)
    assert_response :success
  end

  test "if not teacher, should not get show" do
    log_in_as(@student)
    get teacher_path(@teacher.id)
    assert_redirected_to home_path
  end

end

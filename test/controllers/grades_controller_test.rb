require 'test_helper'

class GradesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @physics = courses(:physics)
    @stud_w_3_cs = students(:three)
    @physics_teach_user = users(:teach_use_3)
  end

  test 'when teacher adds eligible student to course, a new grade is stored' do
    skip
    log_in_as(@physics_teach_user)
    assert is_logged_in?
    c_id = @physics.id
    get new_course_grade_path (c_id)
    assert_response :success
    post "/courses/" + c_id.to_s + "/grades",
      params: { students_name: "Ron Weasley" }
    assert_redirected_to course_path (c_id)
    follow_redirect!
  end

  test 'downcase input from user can be used to query db' do
    skip
    log_in_as(@physics_teach_user)
    assert is_logged_in?
    c_id = @physics.id
    get new_course_grade_path (c_id)
    assert_response :success
    post "/courses/" + c_id.to_s + "/grades",
      params: { students_name: "ronweasley" }
    assert_redirected_to course_path (c_id)
    follow_redirect!
  end
end

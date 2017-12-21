require 'test_helper'

class GradesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get grades_new_url
    assert_response :success
  end

end

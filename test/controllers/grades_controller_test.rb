require 'test_helper'

class GradesControllerTest < ActionDispatch::IntegrationTest
  test "should get grade new" do
    # skip
    get new_grade_url
    assert_response :success
  end

end

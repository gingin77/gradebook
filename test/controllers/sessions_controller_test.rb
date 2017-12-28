require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'login get path is generated and recognized' do
    assert_routing '/login', controller: 'sessions', action: 'new'
  end

  test 'login post path is generated and recognized' do
    assert_routing({path: 'login', method: :post}, {controller: 'sessions', action: 'create'})
  end

  test 'logout path is generated and recognized' do
    assert_routing({method: 'delete', path: 'logout'}, {controller: "sessions", action: "destroy"})
  end

  test "should get new" do
    get login_path
    assert_response :success
  end
end

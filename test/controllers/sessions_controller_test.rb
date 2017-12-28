require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_auth = users(:six)
  end

  test 'login get path is generated and recognized' do
    assert_routing '/login', controller: 'sessions', action: 'new'
  end

  test 'login post path is generated and recognized' do
    assert_routing({path: 'login', method: :post}, {controller: 'sessions', action: 'create'})
  end

  test 'logout path is generated and recognized' do
    assert_routing({method: 'delete', path: 'logout'}, {controller: "sessions", action: "destroy"})
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {
      username: @user_auth.username,
      password: "password"
      }
    assert is_logged_in?
    assert_redirected_to home_path
    follow_redirect!
  end

  test "login attempt invalid" do
    get login_path
    post login_path, params: {
      username: " ",
      password: " " }
    assert_not is_logged_in?
    # assert_template 'sessions/new'
    assert_not flash.empty?
    get login_path
    # assert flash.empty?
  end

  def teardown
    Rails.cache.clear
  end
end

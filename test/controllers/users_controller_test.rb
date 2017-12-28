require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    # @user_not = users(:five)
    @user_auth = users(:six)
  end

  test "login with valid information followed by logout" do
    @user_auth.save
    get login_path
    puts @user_auth.username
    puts @user_auth.password_digest
    post login_path(params: { session: { username: @user_auth.username,
      password_digest: @user_auth.password_digest }})
    puts @user_auth.id
    puts session[:user_id]
    assert test_logged_in?
    # assert_redirected_to home_path
    # follow_redirect!
    # assert_template 'users/show'
    # assert_select "a[href=?]", login_path, count: 0
    # assert_select "a[href=?]", logout_path
    # assert_select "a[href=?]", user_path(@user)
    # delete logout_path
    # assert_not is_logged_in?
    # assert_redirected_to root_url
    # follow_redirect!
    # assert_select "a[href=?]", login_path
    # assert_select "a[href=?]", logout_path,      count: 0
    # assert_select "a[href=?]", user_path(@user), count: 0
  end

  # test "login flow for authorized user" do
  #   skip
  #   get login_path
  #   assert_response :success
  #   @current_user = @user_auth
  #   puts @user_auth.username
  #   puts @user_auth.password_digest
  #
  #   post login_path, params: { session: { username: @user_auth.username,
  #     password_digest: @user_auth.password_digest }}
  #   # follow_redirect!
  #   assert_equal 200, status
  #   assert_equal home_path, path
  # end

  # test "login flow for unauthorized user" do
  #   skip
  #   get login_path
  #   assert_response :success
  #
  #   post login_path, params: { session: { username: @user_not.username,
  #     password_digest: @user_not.password_digest }}
  #   assert_redirected_to login_path
  #   # flash message
  # end
  #
  # test "login with invalid information" do
  #   skip
  #   get login_path
  #   assert_template 'sessions/new'
  #   post login_path, params: { session: { email: "", password: "" } }
  #   assert_template 'sessions/new'
  #   assert_not flash.empty?
  #   get root_path
  #   assert flash.empty?
  # end

end

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
    puts !session[:user_id]=nil?
    assert logged_in?
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
end

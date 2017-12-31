require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def is_logged_in?
    !session[:user_id] == nil?
  end

  def log_in_as(user)
    post login_path, params: {
      username: user.username,
      password: "password"
      }
  end
end

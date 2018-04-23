class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def logged_in?
    current_user != nil
    redirect_to login_path unless current_user
  end
end

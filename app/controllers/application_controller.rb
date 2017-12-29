class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from "CanCan::AccessDenied" do |exception|
    flash[:danger] = "Access denied."
    redirect_to home_path
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
    redirect_to login_path unless current_user
  end
end

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_username(params[:username])
    if user.authenticate(params[:password]) && user
      session[:user_id] = user.id
      redirect_to courses_path
    else
      flash[:notice] = 'Username or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have successfully logged out.'
    redirect_to login_path
  end
end

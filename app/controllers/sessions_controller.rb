class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to courses_path
    else
      flash[:notice] = 'Username or password is invalid'
      render :new
    end
  end
end

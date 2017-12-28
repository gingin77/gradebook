class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash.now[:success]= "Successful login"
      redirect_to home_path
    else
      flash.now[:danger] = 'Username or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = 'You have successfully logged out.'
    redirect_to login_path
  end
end

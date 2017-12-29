class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash.now[:success]= "Successful login"
      redirect_to student_path(user.identifiable_id) if user.student?
      redirect_to teacher_path(user.identifiable_id) if user.teacher?
      redirect_to courses_path if user.admin?
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

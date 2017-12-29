class TeachersController < ApplicationController
  before_action :logged_in?

  def show
    @teacher = Teacher.find(params[:id])
    authorize! :read, @teacher
  end
end

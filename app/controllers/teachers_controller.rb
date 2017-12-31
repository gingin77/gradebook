class TeachersController < ApplicationController
  def show
    @teacher = Teacher.find(params[:id])
    authorize! :show, @teacher
  end
end

class StudentsController < ApplicationController
  before_action :logged_in?

  def index
    @students = Student.all
    authorize @students
  end

  def show
    @student = Student.find(params[:id])
    authorize @student
  end
end

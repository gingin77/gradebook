class StudentsController < ApplicationController
  before_action :logged_in?
  load_and_authorize_resource :class => Student

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end
end

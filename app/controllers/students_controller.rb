class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @gpa = GradeConverter.grds_to_gpa(@student.id)
  end

  def edit
  end

  def update
  end
end

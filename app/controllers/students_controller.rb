class StudentsController < ApplicationController
  # before_action :get_grade, only: :show

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

  private

  # def get_grade
  #   @grade = GradeConverter.find_by_student_id(params[:id])
  # end
end

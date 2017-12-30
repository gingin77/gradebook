class GradesController < ApplicationController
  before_action :logged_in?
  load_and_authorize_resource :grade
  before_action :get_course
  before_action :get_student, only: :create
  before_action :get_grade, only: [:edit, :update, :destroy]

  def new
    @grade = Grade.new
  end

  def create
    @grade = Grade.new do |g|
      g.course_id = @course.id
      g.student_id = @student.id
    end
    if @grade.save
      flash[:success] = @student.name + " has been added to " + @course.course_title
      redirect_to course_path(@course.id)
    else
      flash.now[:danger] = "The student you selected is NOT elligible to be added to this course."
      render 'new'
    end
  end

  def edit
  end

  def update
    @grade.update_attributes(percentage: params[:percentage])
    if @grade.save
      redirect_to course_path(@course.id)
      flash[:success] = "The grade has been updated."
    else
      flash.now[:danger] = "Your entry cannot be saved to the database. You entered: " + @grade.percentage.to_s
      render 'edit'
    end
  end

  def destroy
    @grade.destroy
    redirect_to course_path(@course.id)
    flash[:success] = @grade.get_student_name + " was dropped from the course."
  end

  private

  def student_params
    params.permit(:students_name)
  end

  def grade_params
    params.permit(:percentage)
  end

  def get_course
    @course = Course.find(params[:course_id])
  end

  def get_grade
    @grade = Grade.find(params[:id])
  end

  def get_student
    @student = Student.find_by(name: params[:students_name])
  end
end

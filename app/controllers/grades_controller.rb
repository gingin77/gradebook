class GradesController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :grade, through: :course

  before_action :get_course
  before_action :get_student, only: :create
  before_action :get_grade, only: [:edit, :update, :destroy]

  def new
    @grade = Grade.new
  end

  def create
    if !@student.nil?
      @grade.course_id = @course.id
      @grade.student_id = @student.id
    else
      flash[:danger] = "The name you entered could not be found in our system."
      redirect_to course_path(@course.id) and return
    end
    if @grade.save
      flash[:success] = @student.name + " has been added to " + @course.course_title
      redirect_to course_path(@course.id)
    else
      flash[:danger] = @grade.errors.messages
      redirect_to course_path(@course.id)
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
    query = params[:students_name].split(' ').map {|w| w.camelcase}.join(' ')
    @student = Student.find_by(name: query)
  end
end

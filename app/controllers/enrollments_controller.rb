class EnrollmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :enrollment, through: :course

  before_action :get_course
  before_action :get_student, only: :create
  before_action :get_enrollment, only: [:edit, :update, :destroy]

  def new
    @enrollment = Enrollment.new
  end

  def create
    if !@student.nil?
      @enrollment.course_id = @course.id
      @enrollment.student_id = @student.id
    else
      flash[:danger] = "The name you entered could not be found in our system."
      redirect_to course_path(@course.id) and return
    end
    if @enrollment.save
      flash[:success] = @student.name + " has been added to " + @course.course_title
      redirect_to course_path(@course.id)
    else
      flash[:danger] = @enrollment.errors.messages
      redirect_to course_path(@course.id)
    end
  end

  def edit
  end

  def update
    @enrollment.update_attributes(percentage: params[:percentage])
    if @enrollment.save
      redirect_to course_path(@course.id)
      flash[:success] = "The grade has been updated."
    else
      flash.now[:danger] = "Your entry cannot be saved to the database. You entered: " + @enrollment.percentage.to_s
      render 'edit'
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to course_path(@course.id)
    flash[:success] = @enrollment.get_student_name + " was dropped from the course."
  end

  private

  def student_params
    params.permit(:students_name)
  end

  def enrollment_params
    params.permit(:percentage)
  end

  def get_course
    @course = Course.find(params[:course_id])
  end

  def get_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  def get_student
    query = params[:students_name].split(' ').map {|w| w.camelcase}.join(' ')
    @student = Student.find_by(name: query)
  end
end

class GradesController < ApplicationController
  before_action :logged_in?
  load_and_authorize_resource :grade
  before_action :get_course
  before_action :get_student_id, only: :create

  def new
    @grade = Grade.new
  end

  def index
    @grades = Grade.all
  end

  def show
    @grade = Grade.find_by(params[:id])
  end

  def create
    @grade = Grade.new do |g|
      g.course_id = @course.id
      g.student_id = @student.id
    end
    if @grade.save
      flash.now[:success]
      redirect_to course_path(@course.id)
    else
      flash[:danger] = "The student you selected is NOT elligible to be added to this course."
      render 'new'
    end
  end

  def edit
  end

  def update
    @grade.update!(grade_params)
    if @grade.save
      redirect_to course_path(@course.id)
    else
      render 'edit'
    end
  end

  private
  #
  # def grade_params
  #   params.require(:grade).permit(:student_id, :course_id, :percentage)
  # end

  # def student_params
  #   params.require(:student).permit(:name)
  # end

  def get_course
    @course = Course.find(params[:course_id])
  end

  def get_student_id
    @student = Student.find_by(name: params[:name])
    # Student.find_by(name: params[:name]).id
  end

  # def get_students
  #   @students = Student.all
  # end
end

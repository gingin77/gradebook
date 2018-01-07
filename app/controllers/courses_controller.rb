class CoursesController < ApplicationController
  before_action :logged_in?

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @course_avg = @course.enrollments.average(:percentage).round(2)
    authorize! :manage, @course
  end
end

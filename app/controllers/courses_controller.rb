class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @course_avg = @course.grades.average(:percentage).round(2)
  end
end

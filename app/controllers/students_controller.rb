class StudentsController < ApplicationController
  before_action :logged_in?
  load_and_authorize_resource

  def index
    @students = Student.all
    @gpas_array = GradeConverter.gpas_for_multiple_studs(@students)
    # authorize! :manage, @students
  end

  def show
    @student = Student.find(params[:id])
    @gpa = GradeConverter.grds_to_gpa(@student.id)
    # authorize! :show, @student
  end
end

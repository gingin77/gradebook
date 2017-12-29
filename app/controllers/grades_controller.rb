class GradesController < ApplicationController
  before_action :logged_in?
  # load_and_authorize_resource :grade
  # load_and_authorize_resource :through => :course
  # load_and_authorize_resource :user

  def new
    @grade = Grade.new
  end

  def index
    @grades = Grade.all
    # authorize! :manage, @grades
  end

  def show
    @grade = Grade.find_by(params[:id])
    # authorize! :read, @grades
  end
end

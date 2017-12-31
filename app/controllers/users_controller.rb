class UsersController < ApplicationController
  before_action :logged_in?, only: :show
  before_action :underloaded_academy_members, only: :index

  def index
    @users = User.all
  end

  def show
  end

  private
  def underloaded_academy_members
    @students_who_need_more_classes = Student.all.select {|s| s.grades.count <= 3 }
    @teachers_with_1_or_fewer_classes = Teacher.all.select {|s| s.grades.count <= 1 }
  end
end

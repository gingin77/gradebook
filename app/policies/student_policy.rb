class StudentPolicy < ApplicationPolicy
  attr_reader :user, :enrollment

  def initialize(user, enrollment)
    @user = user
    @enrollment = enrollment
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || user.
  end
end

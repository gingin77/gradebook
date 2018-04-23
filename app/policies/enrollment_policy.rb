class EnrollmentPolicy < ApplicationPolicy
  # class Scope
  #   attr_reader :user, :scope
  #
  #   def initialize(user, scope)
  #     @user  = user
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     if user.teacher?
  #       scope.where(Course.teacher_id == user.identifiable_id)
  #       # the course needs to be identified based on the params;
  #       # the teacher_id foreign_key on course == user.identifiable_id
  #     end
  #   end
  # end

  attr_reader :user, :enrollment

  def initialize(user, enrollment)
    @user = user
    @enrollment = enrollment
  end

  def new?
    user.teacher?
  end

  def create?
    user.teacher?
  end

  def edit?
    user.teacher?
  end

  def update?
    user.teacher?
  end

  def destroy?
    user.teacher?
  end
end

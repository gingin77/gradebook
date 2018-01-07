class Ability
  include CanCan::Ability

  def initialize(user)
    can :show, User
    can :index, Course

    if user.student?
      can :show, Student do |s|
        s&.user == user
      end
    elsif user.teacher?
      can :show, Teacher do |t|
        t&.user == user
      end
      can :manage, Course do |c|
        c.teacher_id == user.identifiable_id
      end
      can :manage, Enrollment
    elsif user.admin?
      can :manage, Student
    end
  end
end

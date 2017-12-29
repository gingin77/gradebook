class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :index, Course
    if user.student?
      can :read, Student do |s|
        s&.user == user
      end
    elsif user.teacher?
      can :read, Teacher do |t|
        t&.user == user
      end
      # can :manage, Grade do |g|
      #   user.has_grade?(g)
      # end
      can :manage, Course do |c|
        c.teacher_id == user.identifiable_id
      end
    end
  end
end

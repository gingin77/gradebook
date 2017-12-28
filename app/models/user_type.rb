class UserType
  def initialize(user)
    @user = user
  end

  def ut_id
    @user.identifiable_id
  end

  def ut_type
    @user.identifiable_type
  end

  def get_name
    if ut_type == "Student"
      students_name
    elsif ut_type == "Teacher"
      teachers_name
    end
  end

  def students_name
    Student.find(ut_id).name
  end

  def teachers_name
    Teacher.find(ut_id).name
  end
end

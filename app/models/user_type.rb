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
      Student.find(ut_id).name
    elsif ut_type == "Teacher"
      Teacher.find(ut_id).name
    elsif ut_type == "Admin"
      Admin.find(ut_id).name
    end
  end
end
